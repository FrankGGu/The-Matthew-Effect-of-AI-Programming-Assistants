class Solution {
    private int maxSum = Integer.MIN_VALUE;

    public int maxPathSum(TreeNode root) {
        calculateMaxPath(root);
        return maxSum;
    }

    private int calculateMaxPath(TreeNode node) {
        if (node == null) return 0;
        int left = Math.max(calculateMaxPath(node.left), 0);
        int right = Math.max(calculateMaxPath(node.right), 0);
        maxSum = Math.max(maxSum, node.val + left + right);
        return node.val + Math.max(left, right);
    }
}