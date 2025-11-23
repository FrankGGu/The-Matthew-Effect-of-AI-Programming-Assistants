import java.util.*;

class Solution {

    // Helper class to store data points (nums1[i], nums2[i], sum)
    static class DataPoint {
        int n1, n2, sum;

        DataPoint(int n1, int n2) {
            this.n1 = n1;
            this.n2 = n2;
            this.sum = n1 + n2;
        }
    }

    // Helper class to store queries (x, y, original_index)
    static class Query {
        int x, y, originalIndex;

        Query(int x, int y, int originalIndex) {
            this.x = x;
            this.y = y;
            this.originalIndex = originalIndex;
        }
    }

    // Segment Tree implementation to find maximum in a range
    static class SegmentTree {
        int[] tree;
        int size;

        SegmentTree(int n) {
            size = n;
            tree = new int[4 * n]; // Max size for segment tree
            Arrays.fill(tree, -1); // Initialize with -1 as per problem requirement (no valid sum)
        }

        // Update: set the maximum value at a specific index
        void update(int idx, int val) {
            update(1, 0, size - 1, idx, val);
        }

        private void update(int node, int start, int end, int idx, int val) {
            if (start == end) {
                tree[node] = Math.max(tree[node], val); // Update with max value
                return;
            }
            int mid = start + (end - start) / 2;
            if (idx <= mid) {
                update(2 * node, start, mid, idx, val);
            } else {
                update(2 * node + 1, mid + 1, end, idx, val);
            }
            tree[node] = Math.max(tree[2 * node], tree[2 * node + 1]); // Propagate max up
        }

        // Query: get the maximum value in a range [l, r]
        int query(int l, int r) {
            if (l > r || l < 0 || r >= size) { // Invalid or out-of-bounds range
                return -1;
            }
            return query(1, 0, size - 1, l, r);
        }

        private int query(int node, int start, int end, int l, int r) {
            if (r < start || end < l) { // No overlap
                return -1;
            }
            if (l <= start && end <= r) { // Full overlap
                return tree[node];
            }
            int mid = start + (end - start) / 2;
            int p1 = query(2 * node, start, mid, l, r);
            int p2 = query(2 * node + 1, mid + 1, end, l, r);
            return Math.max(p1, p2);
        }
    }

    public int[] maximumSumQueries(int[] nums1, int[] nums2, int[][] queriesArr) {
        int n = nums1.length;
        int q = queriesArr.length;

        // 1. Prepare DataPoints from nums1 and nums2
        DataPoint[] dataPoints = new DataPoint[n];
        for (int i = 0; i < n; i++) {
            dataPoints[i] = new DataPoint(nums1[i], nums2[i]);
        }

        // 2. Prepare Queries, storing original index to place results correctly
        Query[] queries = new Query[q];
        for (int i = 0; i < q; i++) {
            queries[i] = new Query(queriesArr[i][0], queriesArr[i][1], i);
        }

        // 3. Coordinate compression for nums2 values
        // Use TreeSet to get sorted unique values, then convert to array
        Set<Integer> distinctN2Set = new TreeSet<>();
        for (int val : nums2) {
            distinctN2Set.add(val);
        }
        int[] distinctN2Arr = new int[distinctN2Set.size()];
        int k = 0;
        for (int val : distinctN2Set) {
            distinctN2Arr[k++] = val;
        }

        // 4. Sort DataPoints by n1 in descending order
        Arrays.sort(dataPoints, (a, b) -> b.n1 - a.n1);

        // 5. Sort Queries by x in descending order
        Arrays.sort(queries, (a, b) -> b.x - a.x);

        // 6. Initialize results array with -1
        int[] ans = new int[q];
        Arrays.fill(ans, -1);

        // 7. Initialize Segment Tree with the size of distinct nums2 values
        SegmentTree segmentTree = new SegmentTree(distinctN2Arr.length);

        // 8. Use a sweep-line algorithm
        int dataPointIdx = 0; // Pointer for sorted dataPoints
        for (Query query : queries) {
            // Add all data points where n1 >= query.x to the segment tree
            // These are potential candidates for the current query
            while (dataPointIdx < n && dataPoints[dataPointIdx].n1 >= query.x) {
                // Find the compressed index for nums2[i]
                int compressedN2Idx = Arrays.binarySearch(distinctN2Arr, dataPoints[dataPointIdx].n2);
                // Update the segment tree with the sum at this compressed index
                segmentTree.update(compressedN2Idx, dataPoints[dataPointIdx].sum);
                dataPointIdx++;
            }

            // For the current query (x, y), we need to find max sum where n2 >= y
            // Find the starting compressed index for y in distinctN2Arr
            int compressedYIdx = Arrays.binarySearch(distinctN2Arr, query.y);
            if (compressedYIdx < 0) {
                compressedYIdx = -(compressedYIdx + 1); // If not found, get insertion point
            }

            // Query the segment tree for the maximum sum in the range [compressedYIdx, last_distinct_n2_index]
            ans[query.originalIndex] = segmentTree.query(compressedYIdx, distinctN2Arr.length - 1);
        }

        return ans;
    }
}