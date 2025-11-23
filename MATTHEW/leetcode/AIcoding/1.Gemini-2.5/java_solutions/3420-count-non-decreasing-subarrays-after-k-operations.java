import java.util.*;

class Solution {

    // NodeData for the segment tree. Stores the maximum LNDS length in its range
    // and the count of elements that achieve this maximum length.
    static class NodeData {
        int maxLen;
        int count;

        NodeData(int maxLen, int count) {
            this.maxLen = maxLen;
            this.count = count;
        }
    }

    // SegmentTree class to manage LNDS lengths for ranges of ranks.
    // It uses a standard segment tree structure for internal nodes,
    // where each node stores a NodeData object.
    // For leaf nodes (representing a single rank), it uses a TreeMap to store
    // all LNDS lengths that end at that rank, along with their frequencies.
    static class SegmentTree {
        NodeData[] treeNodes; // Stores NodeData for internal nodes (maxLen, count)
        TreeMap<Integer, Integer>[] leafMaps; // Stores (length -> count) for each specific rank (leaf)
        int M; // Number of unique ranks

        public SegmentTree(int uniqueValuesCount) {
            M = uniqueValuesCount;
            treeNodes = new NodeData[4 * M];
            // Ranks are 1-indexed, so leafMaps needs M+1 size.
            leafMaps = new TreeMap[M + 1]; 
            for (int i = 0; i < 4 * M; i++) {
                treeNodes[i] = new NodeData(0, 0); // Initialize with 0 length, 0 count
            }
            for (int i = 1; i <= M; i++) {
                leafMaps[i] = new TreeMap<>(); // Initialize each leaf's TreeMap
            }
        }

        // Merges NodeData from two children nodes.
        // If max lengths are different, returns the one with the greater maxLen.
        // If max lengths are equal, sums their counts.
        private NodeData merge(NodeData left, NodeData right) {
            if (left.maxLen > right.maxLen) {
                return left;
            } else if (right.maxLen > left.maxLen) {
                return right;
            } else { // maxLen are equal
                return new NodeData(left.maxLen, left.count + right.count);
            }
        }

        // Updates the TreeMap at the leaf node corresponding to `rank`
        // and propagates changes upwards by recomputing NodeData for parent nodes.
        // `nodeIdx`: current segment tree node index.
        // `start`, `end`: rank range covered by `nodeIdx`.
        // `rank`: the specific rank to update.
        // `length`: the LNDS length to add/remove.
        // `type`: 1 for add, -1 for remove.
        public void update(int nodeIdx, int start, int end, int rank, int length, int type) {
            if (start == end) { // Leaf node reached
                leafMaps[rank].put(length, leafMaps[rank].getOrDefault(length, 0) + type);
                if (leafMaps[rank].get(length) == 0) {
                    leafMaps[rank].remove(length);
                }
                // Update NodeData for this leaf based on its TreeMap
                if (leafMaps[rank].isEmpty()) {
                    treeNodes[nodeIdx] = new NodeData(0, 0);
                } else {
                    int currentMaxLen = leafMaps[rank].lastKey(); // Max length at this rank
                    int currentCount = leafMaps[rank].get(currentMaxLen); // Count for that max length
                    treeNodes[nodeIdx] = new NodeData(currentMaxLen, currentCount);
                }
                return;
            }

            int mid = (start + end) / 2;
            if (rank <= mid) {
                update(2 * nodeIdx, start, mid, rank, length, type);
            } else {
                update(2 * nodeIdx + 1, mid + 1, end, rank, length, type);
            }
            // After children are updated, merge their NodeData to update current node's NodeData
            treeNodes[nodeIdx] = merge(treeNodes[2 * nodeIdx], treeNodes[2 * nodeIdx + 1]);
        }

        // Queries the maximum LNDS length for ranks within the range [1, maxRank].
        // `nodeIdx`: current segment tree node index.
        // `start`, `end`: rank range covered by `nodeIdx`.
        // `maxRank`: the upper bound for the query rank range.
        public int queryMaxLen(int nodeIdx, int start, int end, int maxRank) {
            // If current node's range is completely outside the query range, return 0.
            if (start > maxRank || end < 1) { 
                return 0;
            }
            // If current node's range is completely inside the query range, return its maxLen.
            if (start >= 1 && end <= maxRank) { 
                return treeNodes[nodeIdx].maxLen;
            }

            int mid = (start + end) / 2;
            // Recursively query left and right children
            int leftMax = queryMaxLen(2 * nodeIdx, start, mid, maxRank);
            int rightMax = queryMaxLen(2 * nodeIdx + 1, mid + 1, end, maxRank);
            return Math.max(leftMax, rightMax); // Return the maximum of the two
        }
    }

    public long countNonDecreasingSubarrays(int[] nums, int k) {
        int n = nums.length;

        // Step 1: Coordinate compression for `nums` values.
        // This maps large values to smaller ranks (1 to M), suitable for segment tree indices.
        Set<Integer> uniqueVals = new TreeSet<>();
        for (int num : nums) {
            uniqueVals.add(num);
        }
        Map<Integer, Integer> valToRank = new HashMap<>();
        int rank = 1;
        for (int val : uniqueVals) {
            valToRank.put(val, rank++);
        }
        int M = uniqueVals.size(); // Number of unique ranks

        // Step 2: Initialize data structures for the sliding window.
        // `lndsLengths[i]` stores the LNDS length of `nums[i]` when it was added to the window.
        // This is crucial for correctly removing its contribution when `nums[left]` is removed.
        int[] lndsLengths = new int[n]; 
        SegmentTree st = new SegmentTree(M);
        long totalCount = 0;
        int left = 0; // Left pointer of the sliding window

        // Step 3: Iterate with the right pointer to expand the window.
        for (int right = 0; right < n; right++) {
            int currentVal = nums[right];
            int currentRank = valToRank.get(currentVal);

            // Calculate LNDS length ending at `currentVal` for the current window.
            // This is 1 + the maximum LNDS length ending at any value less than or equal to `currentVal`.
            int prevMaxLen = st.queryMaxLen(1, 1, M, currentRank);
            int currentLen = prevMaxLen + 1;
            lndsLengths[right] = currentLen; // Store this length for `nums[right]`

            // Add this (rank, length) to the segment tree.
            st.update(1, 1, M, currentRank, currentLen, 1); // Type 1 for add

            // Step 4: Shrink the window from the left if the cost exceeds `k`.
            // The cost for a subarray `[left, right]` is `(right - left + 1) - LNDS_length([left, right])`.
            // We need `cost <= k`, which means `LNDS_length([left, right]) >= (right - left + 1) - k`.

            // Get the overall maximum LNDS length for the current window `[left, right]`.
            // This is the maximum length in the entire segment tree (query up to rank M).
            int overallMaxLNDS = st.queryMaxLen(1, 1, M, M);

            while ((right - left + 1) - overallMaxLNDS > k) {
                // Remove `nums[left]` from the window.
                int leftVal = nums[left];
                int leftRank = valToRank.get(leftVal);
                int leftLen = lndsLengths[left]; // Use the stored LNDS length for `nums[left]`

                // Remove this (rank, length) from the segment tree.
                st.update(1, 1, M, leftRank, leftLen, -1); // Type -1 for remove
                left++; // Move left pointer

                // Recalculate overall max LNDS after removal, as it might have changed.
                overallMaxLNDS = st.queryMaxLen(1, 1, M, M);
            }

            // Step 5: If the window `[left, right]` is valid, all subarrays ending at `right`
            // and starting from `left` up to `right` are also valid.
            // The number of such subarrays is `(right - left + 1)`.
            totalCount += (right - left + 1);
        }

        return totalCount;
    }
}