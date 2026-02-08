import java.util.*;

class Solution {

    // Segment Tree Node
    static class SegTreeNode {
        int l, r; // Compressed indices for the range [coords.get(l), coords.get(r+1)-1]
        int covered; // Number of distinct values colored in this node's range
        boolean lazy; // True if this node's entire range is fully colored by a lazy update
        SegTreeNode leftChild, rightChild;

        public SegTreeNode(int l, int r) {
            this.l = l;
            this.r = r;
            this.covered = 0;
            this.lazy = false;
        }
    }

    private List<int[]> allQueries;
    private List<Integer> coords; // Sorted unique coordinate points
    private Map<Integer, Integer> valueToCompressedIdx; // Maps actual value to its compressed index
    private SegTreeNode root;

    public Solution() {
        allQueries = new ArrayList<>();
    }

    public void color(int L, int R) {
        allQueries.add(new int[]{L, R});
    }

    public int getColoredCount() {
        // Step 1: Collect all unique coordinate points (L and R+1 for each query)
        Set<Integer> uniqueCoords = new TreeSet<>();
        for (int[] query : allQueries) {
            uniqueCoords.add(query[0]);
            uniqueCoords.add(query[1] + 1);
        }

        coords = new ArrayList<>(uniqueCoords);
        // Step 2: Build valueToCompressedIdx map
        valueToCompressedIdx = new HashMap<>();
        for (int i = 0; i < coords.size(); i++) {
            valueToCompressedIdx.put(coords.get(i), i);
        }

        // Step 3: Build the segment tree
        // The segment tree operates on compressed indices.
        // If there are k unique coordinates, there are k-1 elementary intervals.
        // E.g., coords = [1, 5, 10] means intervals [1,4] and [5,9].
        // These correspond to compressed indices 0 and 1.
        // So, the range of compressed indices is [0, coords.size() - 2].
        if (coords.size() < 2) {
            return 0; // No intervals to cover
        }
        root = buildTree(0, coords.size() - 2);

        // Step 4: Process all coloring queries
        for (int[] query : allQueries) {
            int queryL = query[0];
            int queryR = query[1];

            // Get compressed indices for the query range
            int queryLIdx = valueToCompressedIdx.get(queryL);
            int queryRIdx = valueToCompressedIdx.get(queryR); // This maps R to its compressed index

            // The segment tree update needs to cover the range [queryL, queryR]
            // which corresponds to compressed indices from `queryLIdx` to `valueToCompressedIdx.get(queryR + 1) - 1`.
            // Example: query [2, 6].
            // If coords are [1, 2, 3, 4, 5, 6, 7, ...].
            // queryLIdx for 2 is 1. queryRIdx for 6 is 5.
            // We want to color intervals [2,2], [3,3], [4,4], [5,5], [6,6].
            // These correspond to compressed indices 1, 2, 3, 4, 5.
            // So, the range of compressed indices for update should be [valueToCompressedIdx.get(L), valueToCompressedIdx.get(R+1) - 1].
            updateTree(root, queryLIdx, valueToCompressedIdx.get(queryR + 1) - 1);
        }

        // Step 5: Return the total distinct colored count from the root
        return root.covered;
    }

    // Builds the segment tree over compressed indices [l, r]
    private SegTreeNode buildTree(int l, int r) {
        SegTreeNode node = new SegTreeNode(l, r);
        if (l == r) {
            return node; // Leaf node
        }
        int mid = l + (r - l) / 2;
        node.leftChild = buildTree(l, mid);
        node.rightChild = buildTree(mid + 1, r);
        return node;
    }

    // Pushes down the lazy flag from parent to children
    private void pushDown(SegTreeNode node) {
        if (node.lazy && node.leftChild != null && node.rightChild != null) {
            // Apply lazy tag to children
            node.leftChild.lazy = true;
            node.rightChild.lazy = true;

            // Update children's covered count based on their full range length
            node.leftChild.covered = coords.get(node.leftChild.r + 1) - coords.get(node.leftChild.l);
            node.rightChild.covered = coords.get(node.rightChild.r + 1) - coords.get(node.rightChild.l);

            // Reset parent's lazy tag after pushing down
            node.lazy = false;
        }
    }

    // Updates the segment tree to mark range [queryLIdx, queryRIdx] as colored
    // queryLIdx and queryRIdx are compressed indices
    private void updateTree(SegTreeNode node, int queryLIdx, int queryRIdx) {
        if (node == null || queryLIdx > queryRIdx) {
            return;
        }

        // If the node's range is completely outside the query range
        if (node.r < queryLIdx || node.l > queryRIdx) {
            return;
        }

        // If the node's range is completely inside the query range
        if (queryLIdx <= node.l && node.r <= queryRIdx) {
            node.lazy = true;
            node.covered = coords.get(node.r + 1) - coords.get(node.l);
            return;
        }

        // Push down lazy flag before recursing
        pushDown(node);

        // Partial overlap, recurse
        updateTree(node.leftChild, queryLIdx, queryRIdx);
        updateTree(node.rightChild, queryLIdx, queryRIdx);

        // After children are updated, update current node's covered count
        // Sum of children's covered counts
        node.covered = node.leftChild.covered + node.rightChild.covered;
    }
}