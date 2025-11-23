class Solution {
    int maxSum;

    public int maxPathSum(TreeNode root) {
        maxSum = Integer.MIN_VALUE;
        dfs(root);
        return maxSum;
    }

    private int dfs(TreeNode node) {
        if (node == null) {
            return 0;
        }

        int leftPathSum = Math.max(0, dfs(node.left));
        int rightPathSum = Math.max(0, dfs(node.right));

        int currentPathSum = node.val + leftPathSum + rightPathSum;
        maxSum = Math.max(maxSum, currentPathSum);

        return node.val + Math.max(leftPathSum, rightPathSum);
    }
}