class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

class Solution {
    private int maxDepth = 0;
    private TreeNode lca = null;

    public TreeNode lcaDeepestLeaves(TreeNode root) {
        findDepth(root, 0);
        return lca;
    }

    private int findDepth(TreeNode node, int depth) {
        if (node == null) return depth;
        int leftDepth = findDepth(node.left, depth + 1);
        int rightDepth = findDepth(node.right, depth + 1);

        if (leftDepth == rightDepth) {
            if (leftDepth > maxDepth) {
                maxDepth = leftDepth;
                lca = node;
            }
        }

        return Math.max(leftDepth, rightDepth);
    }
}