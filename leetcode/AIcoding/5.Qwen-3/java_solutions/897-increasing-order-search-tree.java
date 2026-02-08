public class Solution {
    TreeNode newRoot = null;
    TreeNode curr = null;

    public TreeNode increasingBST(TreeNode root) {
        inorder(root);
        return newRoot;
    }

    private void inorder(TreeNode node) {
        if (node == null) return;
        inorder(node.left);
        if (newRoot == null) {
            newRoot = new TreeNode(node.val);
            curr = newRoot;
        } else {
            curr.right = new TreeNode(node.val);
            curr = curr.right;
        }
        inorder(node.right);
    }

    static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;
        TreeNode() {}
        TreeNode(int val) { this.val = val; }
        TreeNode(int val, TreeNode left, TreeNode right) {
            this.val = val;
            this.left = left;
            this.right = right;
        }
    }
}