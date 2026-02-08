class Solution {
    public int closeLampInTree(TreeNode root) {
        return dfs(root)[0];
    }

    private int[] dfs(TreeNode node) {
        if (node == null) {
            return new int[]{0, 0, 0, 0};
        }
        int[] left = dfs(node.left);
        int[] right = dfs(node.right);
        int[] res = new int[4];
        int state = node.val;
        res[0] = Math.min(left[0] + right[0], left[1] + right[1]) + (state == 0 ? 0 : 1);
        res[1] = Math.min(left[0] + right[0], left[1] + right[1]) + (state == 1 ? 0 : 1);
        res[2] = Math.min(left[2] + right[2], left[3] + right[3]) + (state == 0 ? 1 : 0);
        res[3] = Math.min(left[2] + right[2], left[3] + right[3]) + (state == 1 ? 1 : 0);
        res[0] = Math.min(res[0], res[2] + 1);
        res[0] = Math.min(res[0], res[3] + 2);
        res[1] = Math.min(res[1], res[2] + 2);
        res[1] = Math.min(res[1], res[3] + 1);
        res[2] = Math.min(res[2], res[0] + 1);
        res[3] = Math.min(res[3], res[0] + 2);
        res[2] = Math.min(res[2], res[1] + 2);
        res[3] = Math.min(res[3], res[1] + 1);
        return res;
    }
}