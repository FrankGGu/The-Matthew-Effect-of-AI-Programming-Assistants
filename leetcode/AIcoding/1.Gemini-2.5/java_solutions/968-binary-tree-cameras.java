class Solution {
    private int cameras = 0;

    private static final int NOT_COVERED = 0;
    private static final int COVERED_NO_CAMERA = 1;
    private static final int HAS_CAMERA = 2;

    public int minCameraCover(TreeNode root) {
        if (root == null) {
            return 0;
        }

        int rootState = dfs(root);

        if (rootState == NOT_COVERED) {
            cameras++;
        }

        return cameras;
    }

    private int dfs(TreeNode node) {
        if (node == null) {
            return COVERED_NO_CAMERA;
        }

        int leftState = dfs(node.left);
        int rightState = dfs(node.right);

        if (leftState == NOT_COVERED || rightState == NOT_COVERED) {
            cameras++;
            return HAS_CAMERA;
        }

        if (leftState == HAS_CAMERA || rightState == HAS_CAMERA) {
            return COVERED_NO_CAMERA;
        }

        return NOT_COVERED;
    }
}