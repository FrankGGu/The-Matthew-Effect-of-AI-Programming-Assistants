class Solution {
    int max_sum;

    public int maxPathSum(TreeNode root) {
        max_sum = Integer.MIN_VALUE;
        maxPathSumHelper(root);
        return max_sum;
    }

    private int maxPathSumHelper(TreeNode node) {
        if (node == null) {
            return 0;
        }

        int left_sum = Math.max(0, maxPathSumHelper(node.left));
        int right_sum = Math.max(0, maxPathSumHelper(node.right));

        max_sum = Math.max(max_sum, node.val + left_sum + right_sum);

        return node.val + Math.max(left_sum, right_sum);
    }
}