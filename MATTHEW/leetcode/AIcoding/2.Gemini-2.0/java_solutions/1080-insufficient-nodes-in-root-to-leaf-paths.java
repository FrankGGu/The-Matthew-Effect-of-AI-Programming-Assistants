class Solution {
    public TreeNode sufficientSubset(TreeNode root, int limit) {
        boolean sufficient = hasSufficientPath(root, 0, limit);
        return sufficient ? root : null;
    }

    private boolean hasSufficientPath(TreeNode node, int currentSum, int limit) {
        if (node == null) {
            return false;
        }

        if (node.left == null && node.right == null) {
            return currentSum + node.val >= limit;
        }

        boolean leftSufficient = hasSufficientPath(node.left, currentSum + node.val, limit);
        boolean rightSufficient = hasSufficientPath(node.right, currentSum + node.val, limit);

        if (!leftSufficient) {
            node.left = null;
        }
        if (!rightSufficient) {
            node.right = null;
        }

        return leftSufficient || rightSufficient;
    }
}