import java.util.*;

class Solution {

    // Segment Tree class to efficiently query maximum in a range and update values.
    // It stores the maximum length of a good subsequence ending with a specific value's coordinate.
    static class SegmentTree {
        int[] tree;
        int N_coords; // Number of unique coordinates (distinct values in nums)

        public SegmentTree(int size) {
            N_coords = size;
            // A segment tree typically requires 4*N space for its nodes.
            tree = new int[4 * N_coords]; 
        }

        // Query for the maximum value in the segment tree within the range [l, r] (inclusive coordinates).
        // node: current node index in the tree array.
        // start, end: the coordinate range covered by the current node.
        // l, r: the query coordinate range.
        public int query(int node, int start, int end, int l, int r) {
            // If the current segment [start, end] is completely outside the query range [l, r],
            // return 0 as it contributes nothing to the maximum length.
            if (r < start || end < l) {
                return 0;
            }
            // If the current segment [start, end] is completely within the query range [l, r],
            // return the value stored at this node.
            if (l <= start && end <= r) {
                return tree[node];
            }
            // If there's a partial overlap, recurse on children and combine results.
            int mid = (start + end) / 2;
            int p1 = query(2 * node, start, mid, l, r); // Query left child
            int p2 = query(2 * node + 1, mid + 1, end, l, r); // Query right child
            return Math.max(p1, p2); // Return the maximum of the two children's results.
        }

        // Update the value at a specific coordinate 'idx' in the segment tree.
        // The update operation takes the maximum of the current value and 'val'
        // to ensure we store the longest subsequence ending with that value.
        // node: current node index.
        // start, end: coordinate range covered by the current node.
        // idx: the coordinate to update.
        // val: the new length to consider for the subsequence ending at 'idx'.
        public void update(int node, int start, int end, int idx, int val) {
            // If this is a leaf node (representing a single coordinate), update its value.
            if (start == end) {
                tree[node] = Math.max(tree[node], val); // Store the maximum length
                return;
            }
            // Recurse to find the leaf node corresponding to 'idx'.
            int mid = (start + end) / 2;
            if (start <= idx && idx <= mid) {
                // 'idx' is in the left child's range.
                update(2 * node, start, mid, idx, val);
            } else {
                // 'idx' is in the right child's range.
                update(2 * node + 1, mid + 1, end, idx, val);
            }
            // After updating a child, update the current node (parent) by taking the maximum of its children.
            tree[node] = Math.max(tree[2 * node], tree[2 * node + 1]);
        }
    }

    public int findMaximumLength(int[] nums, int k) {
        // 1. Collect all unique values from `nums` and map them to compressed coordinates.
        // Using TreeSet to automatically get sorted unique values.
        Set<Integer> uniqueValues = new TreeSet<>();
        for (int num : nums) {
            uniqueValues.add(num);
        }

        // Convert to a List for indexed access (used by binary search later).
        List<Integer> uniqueSortedValues = new ArrayList<>(uniqueValues);
        // Map each unique value to its 0-indexed coordinate.
        Map<Integer, Integer> valueToCoord = new HashMap<>();
        for (int i = 0; i < uniqueSortedValues.size(); i++) {
            valueToCoord.put(uniqueSortedValues.get(i), i);
        }

        int M = uniqueSortedValues.size(); // Number of distinct values (coordinates)
        SegmentTree segmentTree = new SegmentTree(M);
        int maxOverallLen = 0; // Stores the maximum length found across all subsequences.

        // 2. Iterate through `nums` to build up the DP state using the segment tree.
        for (int currentVal : nums) {
            // For the current value `currentVal`, we look for previous values `prevVal`
            // such that `prevVal < currentVal` (for distinct and strictly increasing)
            // and `currentVal - prevVal <= k`.
            // This means `prevVal >= currentVal - k`.
            // So, `prevVal` must be in the range `[currentVal - k, currentVal - 1]`.

            // `nums[i]` are positive, so `prevVal` must also be at least 1.
            int lowerBound = Math.max(1, currentVal - k);
            int upperBound = currentVal - 1;

            int maxPrevLen = 0; // Maximum length of a good subsequence ending with a valid `prevVal`.

            // Find the coordinate range for `prevVal` in `uniqueSortedValues`.
            // `coordLower`: index of the first element >= `lowerBound`.
            int coordLower = Collections.binarySearch(uniqueSortedValues, lowerBound);
            if (coordLower < 0) {
                coordLower = -coordLower - 1;
            }

            // `coordUpper`: index of the last element <= `upperBound`.
            int coordUpper = Collections.binarySearch(uniqueSortedValues, upperBound);
            if (coordUpper < 0) {
                coordUpper = -coordUpper - 2; 
            }

            // If the calculated coordinate range is valid (lower <= upper), query the segment tree.
            if (coordLower <= coordUpper) {
                maxPrevLen = segmentTree.query(1, 0, M - 1, coordLower, coordUpper);
            }

            // The new length for a subsequence ending with `currentVal` is `maxPrevLen + 1`.
            // If no valid `prevVal` was found, `maxPrevLen` is 0, so `newLen` will be 1 (currentVal starts a new subsequence).
            int newLen = maxPrevLen + 1;

            // Get the coordinate for `currentVal`.
            int currentCoord = valueToCoord.get(currentVal);
            // Update the segment tree with `newLen` at `currentCoord`.
            // We take `max` because multiple occurrences of `currentVal` in `nums` might lead to different `newLen`s.
            segmentTree.update(1, 0, M - 1, currentCoord, newLen);

            // Update the overall maximum length found so far.
            maxOverallLen = Math.max(maxOverallLen, newLen);
        }

        return maxOverallLen;
    }
}