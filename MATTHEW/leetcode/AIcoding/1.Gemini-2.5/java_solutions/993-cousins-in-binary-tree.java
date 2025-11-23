class Solution {
    private int depthX = -1;
    private int parentX = -1;
    private int depthY = -1;
    private int parentY = -1;

    public boolean isCousins(TreeNode root, int x, int y) {
        dfs(root, null, 0, x, y);
        return depthX == depthY && parentX != parentY;
    }

    private void dfs(TreeNode node, TreeNode parent, int depth, int x, int y) {
        if (node == null) {
            return;
        }

        if (node.val == x) {
            depthX = depth;
            parentX = (parent != null) ? parent.val : -1; 
        } else if (node.val == y) {
            depthY = depth;
            parentY = (parent != null) ? parent.val : -1;
        }

        // Optimization: If both x and y are found, we can stop further traversal.
        // This check prevents unnecessary recursive calls once both target nodes' info is gathered.
        if (depthX != -1 && depthY != -1) {
            return;
        }

        dfs(node.left, node, depth + 1, x, y);

        if (depthX != -1 && depthY != -1) { // Check again after left subtree to potentially stop early
            return;
        }

        dfs(node.right, node, depth + 1, x, y);
    }
}