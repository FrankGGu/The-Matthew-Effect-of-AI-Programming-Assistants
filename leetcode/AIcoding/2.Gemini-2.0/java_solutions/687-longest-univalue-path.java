class Solution {
    int maxLen = 0;

    public int longestUnivaluePath(TreeNode root) {
        if (root == null) return 0;
        maxLen = 0;
        dfs(root, root.val - 1);
        return maxLen;
    }

    private int dfs(TreeNode node, int parentVal) {
        if (node == null) return 0;

        int leftLen = dfs(node.left, node.val);
        int rightLen = dfs(node.right, node.val);

        maxLen = Math.max(maxLen, leftLen + rightLen);

        if (node.val == parentVal) {
            return Math.max(leftLen, rightLen) + 1;
        } else {
            return 0;
        }
    }
}