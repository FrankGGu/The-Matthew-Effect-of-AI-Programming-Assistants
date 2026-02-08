class Solution {
    public int minimumTime(TreeNode root) {
        return dfs(root)[0];
    }

    private int[] dfs(TreeNode node) {
        if (node == null) return new int[]{0, 0};
        int[] left = dfs(node.left);
        int[] right = dfs(node.right);

        int take = node.val + left[1] + right[1];
        int notTake = Math.max(left[0], left[1]) + Math.max(right[0], right[1]);

        return new int[]{take, notTake};
    }
}