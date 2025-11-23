class Solution {
    public int navigation(TreeNode root) {
        if (root == null) {
            return 0;
        }
        int[] res = dfs(root);
        if (res[1] == 0) {
            return 1;
        }
        return res[0];
    }

    private int[] dfs(TreeNode node) {
        if (node == null) {
            return new int[]{0, 0};
        }
        int[] left = dfs(node.left);
        int[] right = dfs(node.right);
        int cameras = left[0] + right[0];
        int covered = left[1] | right[1];
        if (covered == 0) {
            return new int[]{cameras + 1, 2};
        }
        if (left[1] == 2 || right[1] == 2) {
            return new int[]{cameras, 1};
        }
        return new int[]{cameras, 0};
    }
}