class Solution {
    public TreeNode sufficientSubset(TreeNode root, int limit) {
        if (dfs(root, 0, limit)) {
            return null;
        }
        return root;
    }

    private boolean dfs(TreeNode node, int sum, int limit) {
        if (node == null) return true;
        sum += node.val;
        if (node.left == null && node.right == null) {
            return sum < limit;
        }
        boolean left = dfs(node.left, sum, limit);
        boolean right = dfs(node.right, sum, limit);
        if (left) node.left = null;
        if (right) node.right = null;
        return left && right;
    }
}