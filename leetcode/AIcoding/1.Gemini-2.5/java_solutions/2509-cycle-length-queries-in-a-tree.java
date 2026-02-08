class Solution {
    public int[] cycleLengthQueries(int n, int[][] queries) {
        int[] results = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int u = queries[i][0];
            int v = queries[i][1];

            // Calculate depths of original u and v
            int depthU = getDepth(u);
            int depthV = getDepth(v);

            // Find LCA of original u and v
            int lca = findLCA(u, v);
            int depthLCA = getDepth(lca);

            // Apply the formula: distance(u, LCA) + distance(v, LCA) + 1 (for the new edge)
            // distance(x, y) = depth(x) - depth(y) if y is an ancestor of x
            // Cycle length = (depthU - depthLCA) + (depthV - depthLCA) + 1
            results[i] = depthU + depthV - 2 * depthLCA + 1;
        }
        return results;
    }

    // Helper to get depth of a node in a perfect binary tree (root 1 has depth 0)
    private int getDepth(int node) {
        // For a node 'x', its depth (0-indexed, root at depth 0) is floor(log2(x)).
        // Integer.numberOfLeadingZeros(node) returns the number of zero bits preceding the highest-set bit.
        // For a 32-bit integer, 31 - Integer.numberOfLeadingZeros(node) gives floor(log2(node)).
        return 31 - Integer.numberOfLeadingZeros(node);
    }

    // Helper to find the Lowest Common Ancestor (LCA) of two nodes
    // in a perfect binary tree where parent of i is i/2.
    private int findLCA(int u, int v) {
        // Lift the deeper node until both are at the same depth
        while (getDepth(u) > getDepth(v)) {
            u /= 2;
        }
        while (getDepth(v) > getDepth(u)) {
            v /= 2;
        }

        // Now u and v are at the same depth.
        // Lift both nodes simultaneously until they meet (which is the LCA)
        while (u != v) {
            u /= 2;
            v /= 2;
        }
        return u; // u (or v) is the LCA
    }
}