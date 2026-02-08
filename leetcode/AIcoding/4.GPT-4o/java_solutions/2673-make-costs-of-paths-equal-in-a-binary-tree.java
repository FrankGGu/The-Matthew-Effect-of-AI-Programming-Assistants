class Solution {
    public int minCost(TreeNode root) {
        int[] result = new int[1];
        int[] total = new int[1];
        dfs(root, result, total);
        return result[0];
    }

    private int dfs(TreeNode node, int[] result, int[] total) {
        if (node == null) return 0;
        int left = dfs(node.left, result, total);
        int right = dfs(node.right, result, total);
        total[0] += left + right;
        int expected = (left + right + node.val) / 3;
        result[0] += Math.abs(left - expected) + Math.abs(right - expected);
        return left + right + node.val;
    }
}