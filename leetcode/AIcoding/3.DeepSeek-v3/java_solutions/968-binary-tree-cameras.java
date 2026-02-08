class Solution {
    private int result = 0;

    public int minCameraCover(TreeNode root) {
        return (dfs(root) == 0 ? 1 : 0) + result;
    }

    private int dfs(TreeNode node) {
        if (node == null) return 2;
        int left = dfs(node.left);
        int right = dfs(node.right);
        if (left == 0 || right == 0) {
            result++;
            return 1;
        }
        return left == 1 || right == 1 ? 2 : 0;
    }
}