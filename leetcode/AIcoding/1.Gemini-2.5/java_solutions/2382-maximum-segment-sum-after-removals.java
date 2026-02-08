class Solution {
    private int[] parent;
    private long[] segmentSum;
    private int N;

    // Finds the representative (root) of the set containing element i
    public int find(int i) {
        if (parent[i] == i) {
            return i;
        }
        // Path compression: make i's parent the root directly
        return parent[i] = find(parent[i]);
    }

    // Unites the sets containing elements i and j
    public void union(int i, int j) {
        int rootI = find(i);
        int rootJ = find(j);

        if (rootI != rootJ) {
            // Merge rootJ's set into rootI's set
            parent[rootJ] = rootI;
            segmentSum[rootI] += segmentSum[rootJ];
        }
    }

    public long[] maximumSegmentSum(int[] nums, int[] removeQueries) {
        N = nums.length;
        int M = removeQueries.length;
        long[] ans = new long[M];

        parent = new int[N];
        segmentSum = new long[N];
        // isPresent tracks which elements are currently part of the array (not removed)
        boolean[] isPresent = new boolean[N]; 

        // Initialize DSU: each element is its own parent and forms a segment of its own value
        for (int i = 0; i < N; i++) {
            parent[i] = i;
            segmentSum[i] = nums[i];
            // Initially, all elements are considered "removed" in our reverse processing approach
            // so isPresent remains false for all elements.
        }

        long currentMaxSegmentSum = 0;

        // Process removeQueries in reverse order
        // This simulates adding elements back into the array
        for (int k = M - 1; k >= 0; k--) {
            // The answer for the k-th query is the maximum segment sum
            // *before* the element removeQueries[k] is "added back".
            // This corresponds to the state *after* the k-th removal in the original problem order.
            ans[k] = currentMaxSegmentSum;

            int idx = removeQueries[k];
            isPresent[idx] = true; // Mark this element as now present

            // The element itself, when added, forms a segment. Update max if it's larger.
            currentMaxSegmentSum = Math.max(currentMaxSegmentSum, nums[idx]);

            // Check and merge with left neighbor if it's present
            if (idx > 0 && isPresent[idx - 1]) {
                union(idx, idx - 1);
                // After union, the segment sum of the new root might be the new maximum
                currentMaxSegmentSum = Math.max(currentMaxSegmentSum, segmentSum[find(idx)]);
            }

            // Check and merge with right neighbor if it's present
            if (idx < N - 1 && isPresent[idx + 1]) {
                union(idx, idx + 1);
                // After union, the segment sum of the new root might be the new maximum
                currentMaxSegmentSum = Math.max(currentMaxSegmentSum, segmentSum[find(idx)]);
            }
        }

        return ans;
    }
}