class Solution {
    private int max_so_far;

    public int maxPathSum(TreeNode root) {
        max_so_far = Integer.MIN_VALUE;
        dfs(root);
        return max_so_far;
    }

    private int dfs(TreeNode node) {
        if (node == null) {
            return 0;
        }

        int left_sum = Math.max(0, dfs(node.left));
        int right_sum = Math.max(0, dfs(node.right));

        max_so_far = Math.max(max_so_far, node.val + left_sum + right_sum);

        return node.val + Math.max(left_sum, right_sum);
    }
}