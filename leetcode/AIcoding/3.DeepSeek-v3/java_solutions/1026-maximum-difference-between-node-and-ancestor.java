class Solution {
    public int maxAncestorDiff(TreeNode root) {
        return helper(root, root.val, root.val);
    }

    private int helper(TreeNode node, int min, int max) {
        if (node == null) {
            return max - min;
        }
        min = Math.min(min, node.val);
        max = Math.max(max, node.val);
        int left = helper(node.left, min, max);
        int right = helper(node.right, min, max);
        return Math.max(left, right);
    }
}