class Solution {
    private int maxSum = 0;

    public int maxSumBST(TreeNode root) {
        dfs(root);
        return maxSum;
    }

    private int[] dfs(TreeNode node) {
        if (node == null) return new int[]{1, 0, Integer.MAX_VALUE, Integer.MIN_VALUE};

        int[] left = dfs(node.left);
        int[] right = dfs(node.right);

        if (left[0] == 1 && right[0] == 1 && node.val > left[3] && node.val < right[2]) {
            int sum = left[1] + right[1] + node.val;
            maxSum = Math.max(maxSum, sum);
            return new int[]{1, sum, Math.min(node.val, left[2]), Math.max(node.val, right[3])};
        }

        return new int[]{0, 0, 0, 0};
    }
}