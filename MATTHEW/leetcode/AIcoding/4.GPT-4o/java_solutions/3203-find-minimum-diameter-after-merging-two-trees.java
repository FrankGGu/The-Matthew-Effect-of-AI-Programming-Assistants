class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

public class Solution {
    public int findMinimumDiameter(TreeNode root1, TreeNode root2, int m) {
        int[] result = new int[1];
        result[0] = Integer.MAX_VALUE;
        dfs(root1, m, result);
        dfs(root2, m, result);
        return result[0];
    }

    private int dfs(TreeNode node, int m, int[] result) {
        if (node == null) return 0;
        int left = dfs(node.left, m, result);
        int right = dfs(node.right, m, result);
        int diameter = left + right;
        if (diameter <= m) {
            result[0] = Math.min(result[0], diameter);
        }
        return Math.max(left, right) + 1;
    }
}