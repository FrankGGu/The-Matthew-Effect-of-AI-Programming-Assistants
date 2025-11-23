class Solution {
    public int minFlips(TreeNode root) {
        int[] result = dfs(root);
        return Math.min(result[0], result[1]);
    }

    private int[] dfs(TreeNode node) {
        if (node == null) {
            return new int[] {0, 1};
        }

        int[] left = dfs(node.left);
        int[] right = dfs(node.right);

        int illuminate = left[1] + right[1];
        int notIlluminate = Math.min(left[1] + right[0], Math.min(left[0] + right[1], left[0] + right[0])) + 1;

        return new int[] {illuminate, notIlluminate};
    }
}