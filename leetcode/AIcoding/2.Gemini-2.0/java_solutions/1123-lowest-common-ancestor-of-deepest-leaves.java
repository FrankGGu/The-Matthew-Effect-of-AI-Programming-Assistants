class Solution {
    private int maxDepth = -1;
    private TreeNode lca = null;

    public TreeNode lcaDeepestLeaves(TreeNode root) {
        dfs(root, 0);
        return lca;
    }

    private int dfs(TreeNode node, int depth) {
        if (node == null) {
            return depth;
        }

        int leftDepth = dfs(node.left, depth + 1);
        int rightDepth = dfs(node.right, depth + 1);

        if (leftDepth == rightDepth) {
            if (leftDepth >= maxDepth) {
                maxDepth = leftDepth;
                lca = node;
            }
        } else if (leftDepth > rightDepth) {

        } else {

        }

        return Math.max(leftDepth, rightDepth);
    }
}