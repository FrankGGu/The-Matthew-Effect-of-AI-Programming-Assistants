class Solution {
    int maxLen = 0;

    public int longestZigZag(TreeNode root) {
        dfs(root, true, 0);
        dfs(root, false, 0);
        return maxLen;
    }

    private void dfs(TreeNode node, boolean goLeft, int len) {
        if (node == null) {
            return;
        }

        maxLen = Math.max(maxLen, len);

        if (goLeft) {
            dfs(node.left, false, len + 1);
            dfs(node.right, true, 1);
        } else {
            dfs(node.right, true, len + 1);
            dfs(node.left, false, 1);
        }
    }
}