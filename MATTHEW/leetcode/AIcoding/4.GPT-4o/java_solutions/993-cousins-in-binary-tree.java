class Solution {
    private TreeNode xParent, yParent;
    private int xDepth, yDepth;

    public boolean isCousins(TreeNode root, int x, int y) {
        dfs(root, x, y, 0, null);
        return xDepth == yDepth && xParent != yParent;
    }

    private void dfs(TreeNode node, int x, int y, int depth, TreeNode parent) {
        if (node == null) return;
        if (node.val == x) {
            xParent = parent;
            xDepth = depth;
        }
        if (node.val == y) {
            yParent = parent;
            yDepth = depth;
        }
        dfs(node.left, x, y, depth + 1, node);
        dfs(node.right, x, y, depth + 1, node);
    }
}