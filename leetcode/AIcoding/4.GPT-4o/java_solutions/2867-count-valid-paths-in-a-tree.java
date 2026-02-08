class Solution {
    public int countValidPaths(TreeNode root, int min, int max) {
        return dfs(root, min, max);
    }

    private int dfs(TreeNode node, int min, int max) {
        if (node == null) return 0;
        if (node.val < min || node.val > max) return 0;
        if (node.left == null && node.right == null) return 1;

        return dfs(node.left, min, max) + dfs(node.right, min, max);
    }
}