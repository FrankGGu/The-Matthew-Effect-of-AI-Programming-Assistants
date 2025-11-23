public class Solution {
    public TreeNode increasingBST(TreeNode root) {
        return dfs(root, null);
    }

    private TreeNode dfs(TreeNode node, TreeNode prev) {
        if (node == null) {
            return prev;
        }
        TreeNode newRoot = dfs(node.left, prev);
        node.left = null;
        return dfs(node.right, node);
    }

    static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode() {}

        TreeNode(int val) {
            this.val = val;
        }

        TreeNode(int val, TreeNode left, TreeNode right) {
            this.val = val;
            this.left = left;
            this.right = right;
        }
    }
}