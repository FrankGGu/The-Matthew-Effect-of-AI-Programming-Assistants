class Solution {
    public TreeNode sufficientSubset(TreeNode root, int limit) {
        return sufficientSubsetHelper(root, 0, limit);
    }

    private TreeNode sufficientSubsetHelper(TreeNode node, int currentPathSum, int limit) {
        if (node == null) {
            return null;
        }

        int newPathSum = currentPathSum + node.val;

        // If it's a leaf node
        if (node.left == null && node.right == null) {
            if (newPathSum < limit) {
                return null;
            } else {
                return node;
            }
        }

        // If it's an internal node, recursively process its children
        node.left = sufficientSubsetHelper(node.left, newPathSum, limit);
        node.right = sufficientSubsetHelper(node.right, newPathSum, limit);

        // After processing children, check if this node becomes effectively a leaf
        // (i.e., both children were pruned)
        if (node.left == null && node.right == null) {
            // If it became an effective leaf, we need to check if the path to it is sufficient
            if (newPathSum < limit) {
                return null;
            } else {
                return node;
            }
        }

        // If at least one child remains, this node is part of a sufficient path
        return node;
    }
}