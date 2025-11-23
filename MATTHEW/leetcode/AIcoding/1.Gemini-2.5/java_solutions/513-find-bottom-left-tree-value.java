class Solution {
    private int maxDepth = -1;
    private int bottomLeftValue = 0;

    public int findBottomLeftValue(TreeNode root) {
        dfs(root, 0);
        return bottomLeftValue;
    }

    private void dfs(TreeNode node, int currentDepth) {
        if (node == null) {
            return;
        }

        if (currentDepth > maxDepth) {
            maxDepth = currentDepth;
            bottomLeftValue = node.val;
        }

        dfs(node.left, currentDepth + 1);
        dfs(node.right, currentDepth + 1);
    }
}