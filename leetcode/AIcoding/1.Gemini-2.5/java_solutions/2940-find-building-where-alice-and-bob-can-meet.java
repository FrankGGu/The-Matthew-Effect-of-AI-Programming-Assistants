class Solution {
    private int[] heights;
    private int[] tree; // Stores max height in range

    public int[] findBuildingWhereAliceAndBobCanMeet(int[] heights, int[][] queries) {
        this.heights = heights;
        int n = heights.length;
        tree = new int[4 * n]; // Segment tree array, typically 4*N size is safe

        build(1, 0, n - 1); // Build the segment tree

        int q = queries.length;
        int[] ans = new int[q];

        for (int i = 0; i < q; i++) {
            int aliceStart = queries[i][0];
            int bobStart = queries[i][1];

            if (aliceStart == bobStart) {
                // Special Case: Alice and Bob are at the same building.
                // If heights[aliceStart] is greater than or equal to heights[j] for all j > aliceStart,
                // they meet at aliceStart.
                // Otherwise, they meet at the smallest k > aliceStart such that heights[k] > heights[aliceStart].

                if (aliceStart == n - 1) { // If it's the last building, no buildings to the right
                    ans[i] = aliceStart;
                } else {
                    // Find the maximum height in the range [aliceStart + 1, n - 1]
                    int maxRightHeight = queryMax(1, 0, n - 1, aliceStart + 1, n - 1);

                    if (heights[aliceStart] >= maxRightHeight) {
                        ans[i] = aliceStart;
                    } else {
                        // Find the smallest k > aliceStart such that heights[k] > heights[aliceStart]
                        ans[i] = findSmallestK(1, 0, n - 1, aliceStart + 1, n - 1, heights[aliceStart]);
                        // findSmallestK returns Integer.MAX_VALUE if no such building is found.
                        // Based on the problem statement, if maxRightHeight > heights[aliceStart], such a building must exist.
                        // So, ans[i] should not be Integer.MAX_VALUE here.
                    }
                }
            } else {
                // General Case: Alice and Bob are at different buildings.
                // They need to meet in a building k such that:
                // 1. k > aliceStart
                // 2. k > bobStart
                // 3. heights[k] > heights[aliceStart]
                // 4. heights[k] > heights[bobStart]

                // Combine conditions 1 and 2: k must be > max(aliceStart, bobStart)
                int startSearchIdx = Math.max(aliceStart, bobStart);

                // Combine conditions 3 and 4: heights[k] must be > max(heights[aliceStart], heights[bobStart])
                int minHeightThreshold = Math.max(heights[aliceStart], heights[bobStart]);

                // Find the smallest k in the range [startSearchIdx + 1, n - 1]
                // such that heights[k] > minHeightThreshold
                ans[i] = findSmallestK(1, 0, n - 1, startSearchIdx + 1, n - 1, minHeightThreshold);

                if (ans[i] == Integer.MAX_VALUE) {
                    ans[i] = -1; // No such building found
                }
            }
        }

        return ans;
    }

    // Builds the segment tree. Each node stores the maximum height in its corresponding range.
    private void build(int node, int start, int end) {
        if (start == end) {
            tree[node] = heights[start];
        } else {
            int mid = (start + end) / 2;
            build(2 * node, start, mid);
            build(2 * node + 1, mid + 1, end);
            tree[node] = Math.max(tree[2 * node], tree[2 * node + 1]);
        }
    }

    // Queries for the maximum height in a given range [queryL, queryR].
    // Returns -1 if the query range is invalid or out of bounds for heights (e.g., empty range).
    private int queryMax(int node, int currentL, int currentR, int queryL, int queryR) {
        // If the current segment tree range is completely outside the query range, or query range is invalid
        if (currentR < queryL || currentL > queryR || queryL > currentR) {
            return -1; // Indicates no valid height found in this range
        }

        // If the current segment tree range is completely within the query range
        if (queryL <= currentL && currentR <= queryR) {
            return tree[node];
        }

        // Partially overlapping, recurse on children
        int mid = (currentL + currentR) / 2;
        int p1 = queryMax(2 * node, currentL, mid, queryL, queryR);
        int p2 = queryMax(2 * node + 1, mid + 1, currentR, queryL, queryR);

        return Math.max(p1, p2);
    }

    // Finds the smallest index k in the range [queryL, queryR]
    // such that heights[k] is strictly greater than minHeightThreshold.
    // Returns Integer.MAX_VALUE if no such index is found.
    private int findSmallestK(int node, int currentL, int currentR, int queryL, int queryR, int minHeightThreshold) {
        // If the current segment tree range is completely outside the query range, or query range is invalid
        if (currentR < queryL || currentL > queryR || queryL > currentR) {
            return Integer.MAX_VALUE;
        }

        // If the maximum height in the current segment tree range is not greater than the threshold,
        // then no building in this range can satisfy the condition.
        if (tree[node] <= minHeightThreshold) {
            return Integer.MAX_VALUE;
        }

        // If we are at a leaf node and its height is greater than the threshold,
        // this is a candidate for the smallest index.
        if (currentL == currentR) {
            return currentL; // heights[currentL] is tree[node], which is > minHeightThreshold
        }

        // Recursively search in the left child first to find the smallest index
        int mid = (currentL + currentR) / 2;
        int leftResult = findSmallestK(2 * node, currentL, mid, queryL, queryR, minHeightThreshold);

        if (leftResult != Integer.MAX_VALUE) {
            return leftResult; // Found a valid index in the left child, which is guaranteed to be smaller
        }

        // If not found in the left child, search in the right child
        return findSmallestK(2 * node + 1, mid + 1, currentR, queryL, queryR, minHeightThreshold);
    }
}