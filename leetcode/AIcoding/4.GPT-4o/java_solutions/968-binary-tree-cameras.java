class Solution {
    int cameraCount = 0;

    public int minCameraCover(TreeNode root) {
        if (dfs(root) == 0) {
            cameraCount++;
        }
        return cameraCount;
    }

    private int dfs(TreeNode node) {
        if (node == null) return 1;
        int left = dfs(node.left);
        int right = dfs(node.right);
        if (left == 0 || right == 0) {
            cameraCount++;
            return 2;
        }
        return (left == 2 || right == 2) ? 1 : 0;
    }
}