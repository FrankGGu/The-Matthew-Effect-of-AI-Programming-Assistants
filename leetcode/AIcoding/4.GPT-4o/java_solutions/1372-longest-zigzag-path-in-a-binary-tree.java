class Solution {
    int maxLength = 0;

    public int longestZigZag(TreeNode root) {
        dfs(root, 0, true);
        dfs(root, 0, false);
        return maxLength;
    }

    private void dfs(TreeNode node, int length, boolean isLeft) {
        if (node == null) return;
        maxLength = Math.max(maxLength, length);
        if (isLeft) {
            dfs(node.left, length + 1, false);
            dfs(node.right, 1, true);
        } else {
            dfs(node.right, length + 1, true);
            dfs(node.left, 1, false);
        }
    }
}