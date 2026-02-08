import java.util.ArrayList;
import java.util.List;

class Solution {

    private static final int EMPTY = 1;
    private static final int FULL = -1;
    private static final int NO_LAZY = 0;

    private class NodeData {
        int maxPrefix;    // Maximum empty length from the start of the range
        int maxSuffix;    // Maximum empty length from the end of the range
        int maxOverall;   // Maximum empty length anywhere in the range
        int len;          // Length of the range this NodeData represents

        // Constructor for a NodeData representing a range [L, R]
        // If L > R, it's a dummy node for out-of-range, representing an empty segment.
        NodeData(int L, int R) {
            if (L > R) { // Dummy node for out-of-range
                this.len = 0;
                this.maxPrefix = 0;
                this.maxSuffix = 0;
                this.maxOverall = 0;
            } else { // Actual range, initially fully empty
                this.len = R - L + 1;
                this.maxPrefix = this.len;
                this.maxSuffix = this.len;
                this.maxOverall = this.len;
            }
        }
    }

    private class Node {
        Node left, right;
        NodeData data;
        int lazy; // 0: no_lazy, 1: empty, -1: full

        Node() {
            this.lazy = NO_LAZY;
        }
    }

    private int MAX_COORD;
    private Node root;

    public List<Boolean> blockPlacementQueries(int n, int[][] queries) {
        MAX_COORD = n;
        root = new Node();
        root.data = new NodeData(1, MAX_COORD); // Initially, the entire range [1, n] is empty

        List<Boolean> results = new ArrayList<>();

        for (int[] query : queries) {
            int x = query[0];
            int y = query[1];

            // Query the maximum empty space in the range [1, x]
            NodeData res = querySegmentTree(root, 1, MAX_COORD, 1, x);

            if (res.maxOverall >= y) {
                results.add(true);
                // Place the block: update the range [x - y + 1, x] to be full
                // The problem asks if it's possible to place a block of length y such that its
                // rightmost endpoint is at position x or to its left.
                // If maxOverall empty space in [1, x] is >= y, it means such a space exists.
                // We then occupy the positions [x - y + 1, x] as a concrete placement.
                updateSegmentTree(root, 1, MAX_COORD, x - y + 1, x, FULL);
            } else {
                results.add(false);
            }
        }

        return results;
    }

    private void pushDown(Node node, int L, int R) {
        if (node.lazy == NO_LAZY || L == R) {
            return;
        }

        int mid = L + (R - L) / 2;

        if (node.left == null) {
            node.left = new Node();
            node.left.data = new NodeData(L, mid); // Initialize as empty
        }
        if (node.right == null) {
            node.right = new Node();
            node.right.data = new NodeData(mid + 1, R); // Initialize as empty
        }

        applyLazy(node.left, L, mid, node.lazy);
        applyLazy(node.right, mid + 1, R, node.lazy);
        node.lazy = NO_LAZY;
    }

    private void applyLazy(Node node, int L, int R, int value) {
        if (value == FULL) {
            node.data.maxPrefix = 0;
            node.data.maxSuffix = 0;
            node.data.maxOverall = 0;
        } else if (value == EMPTY) { 
            // This case is not strictly used in this problem (we only set to FULL),
            // but for a general segment tree with EMPTY updates, it would be:
            node.data.maxPrefix = R - L + 1;
            node.data.maxSuffix = R - L + 1;
            node.data.maxOverall = R - L + 1;
        }
        node.lazy = value;
    }

    private void pullUp(Node node, int L, int R) {
        int mid = L + (R - L) / 2;
        // If a child is null, it means that part of the range is still in its initial empty state.
        // So, we create a NodeData representing an empty range for that child.
        NodeData leftData = (node.left == null) ? new NodeData(L, mid) : node.left.data;
        NodeData rightData = (node.right == null) ? new NodeData(mid + 1, R) : node.right.data;
        node.data = merge(leftData, rightData);
    }

    private NodeData merge(NodeData left, NodeData right) {
        NodeData res = new NodeData(0, -1); // Dummy node for result, then fill its properties
        res.len = left.len + right.len;

        res.maxPrefix = left.maxPrefix;
        if (left.maxPrefix == left.len) { // If left child is entirely empty
            res.maxPrefix += right.maxPrefix; // Extend with right child's prefix
        }

        res.maxSuffix = right.maxSuffix;
        if (right.maxSuffix == right.len) { // If right child is entirely empty
            res.maxSuffix += left.maxSuffix; // Extend with left child's suffix
        }

        res.maxOverall = Math.max(left.maxOverall, right.maxOverall);
        res.maxOverall = Math.max(res.maxOverall, left.maxSuffix + right.maxPrefix);
        return res;
    }

    private void updateSegmentTree(Node node, int L, int R, int queryL, int queryR, int value) {
        if (queryL > R || queryR < L) { // No overlap
            return;
        }

        if (queryL <= L && R <= queryR) { // Full overlap
            applyLazy(node, L, R, value);
            return;
        }

        pushDown(node, L, R); // Propagate lazy tag before going down

        int mid = L + (R - L) / 2;

        updateSegmentTree(node.left, L, mid, queryL, queryR, value);
        updateSegmentTree(node.right, mid + 1, R, queryL, queryR, value);

        pullUp(node, L, R); // Recalculate current node's data from children
    }

    private NodeData querySegmentTree(Node node, int L, int R, int queryL, int queryR) {
        if (queryL > R || queryR < L) { // No overlap
            return new NodeData(0, -1); // Dummy node for out-of-range
        }

        if (queryL <= L && R <= queryR) { // Full overlap
            return node.data;
        }

        pushDown(node, L, R); // Propagate lazy tag before going down

        int mid = L + (R - L) / 2;
        NodeData leftResult = querySegmentTree(node.left, L, mid, queryL, queryR);
        NodeData rightResult = querySegmentTree(node.right, mid + 1, R, queryL, queryR);

        return merge(leftResult, rightResult);
    }
}