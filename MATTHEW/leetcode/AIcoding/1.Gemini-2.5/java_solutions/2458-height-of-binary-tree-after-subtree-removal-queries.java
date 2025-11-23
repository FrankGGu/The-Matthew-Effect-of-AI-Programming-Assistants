class Solution {
    private int[] downHeight; // downHeight[node.val] stores the height of the subtree rooted at node
    private int[] ans;        // ans[node.val] stores the height of the tree after removing node's subtree

    public int[] treeQueries(TreeNode root, int[] queries) {
        // Node values are 1 to 10^5, so array size 100001 is sufficient.
        downHeight = new int[100001]; 
        ans = new int[100001];

        // DFS1: Calculate downHeight for all nodes using a post-order traversal.
        // downHeight[node.val] will store the number of edges on the longest path
        // from 'node' to a leaf in its subtree. A single node has height 0, an empty
        // subtree has height -1.
        calculateDownHeight(root);

        // DFS2: Calculate the answer for each node using a pre-order traversal.
        // The 'maxHeightFromParentSide' parameter passed to this DFS represents
        // the maximum height of the tree if the current 'node' is removed.
        // This value is essentially the maximum depth of any node NOT in the current node's subtree.
        // For the root, if it's removed, the tree becomes empty, so its height is -1.
        calculateAns(root, -1); 

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            result[i] = ans[queries[i]];
        }
        return result;
    }

    // Calculates the height of the subtree rooted at 'node'.
    // This is a post-order traversal (bottom-up).
    private int calculateDownHeight(TreeNode node) {
        if (node == null) {
            return -1; // Height of an empty tree is -1
        }
        int leftHeight = calculateDownHeight(node.left);
        int rightHeight = calculateDownHeight(node.right);

        // Height of current node is 1 + max height of its children's subtrees.
        downHeight[node.val] = 1 + Math.max(leftHeight, rightHeight);
        return downHeight[node.val];
    }

    // Calculates the height of the tree after removing each node's subtree.
    // This is a pre-order traversal (top-down).
    // 'maxHeightFromParentSide' for 'node' is the height of the tree if 'node' is removed.
    private void calculateAns(TreeNode node, int maxHeightFromParentSide) {
        if (node == null) {
            return;
        }

        // The answer for the current node 'node' is the 'maxHeightFromParentSide' value
        // that was passed to it. This value represents the maximum depth of any node
        // in the tree that is not part of 'node's subtree.
        ans[node.val] = maxHeightFromParentSide;

        // Get the down heights of children. If a child is null, its height is -1.
        int leftChildHeight = (node.left == null) ? -1 : downHeight[node.left.val];
        int rightChildHeight = (node.right == null) ? -1 : downHeight[node.right.val];

        // For the left child:
        // 'passToLeftChild' will be the height of the tree if 'node.left' is removed.
        // This is the maximum of two possibilities:
        // 1. The path that goes up from 'node.left' to 'node', then continues along the
        //    'maxHeightFromParentSide' path (which is the height of the tree if 'node' is removed).
        //    We add 1 for the edge from 'node.left' to 'node'. So, 'maxHeightFromParentSide + 1'.
        // 2. The path that goes up from 'node.left' to 'node', then goes down 'node.right' subtree.
        //    The height of this path is 'rightChildHeight + 1' (1 for the edge from 'node' to 'node.right').
        int passToLeftChild = Math.max(maxHeightFromParentSide + 1, rightChildHeight + 1);
        calculateAns(node.left, passToLeftChild);

        // For the right child:
        // Similarly, 'passToRightChild' will be the height of the tree if 'node.right' is removed.
        // It's the maximum of:
        // 1. 'maxHeightFromParentSide + 1' (path going up from 'node.right' to 'node', then along 'maxHeightFromParentSide').
        // 2. 'leftChildHeight + 1' (path going from 'node.right' to 'node', then down 'node.left' subtree).
        int passToRightChild = Math.max(maxHeightFromParentSide + 1, leftChildHeight + 1);
        calculateAns(node.right, passToRightChild);
    }
}

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}