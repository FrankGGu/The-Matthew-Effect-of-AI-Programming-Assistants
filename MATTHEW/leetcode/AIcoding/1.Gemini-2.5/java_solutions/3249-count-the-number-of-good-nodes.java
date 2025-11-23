class Solution {
    public int goodNodes(TreeNode root) {
        return dfs(root, Integer.MIN_VALUE);
    }

    private int dfs(TreeNode node, int maxSoFar) {
        if (node == null) {
            return 0;
        }

        int count = 0;
        if (node.val >= maxSoFar) {
            count = 1;
        }

        int newMax = Math.max(maxSoFar, node.val);

        count += dfs(node.left, newMax);
        count += dfs(node.right, newMax);

        return count;
    }
}