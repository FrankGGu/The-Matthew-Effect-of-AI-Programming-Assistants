public class Solution {
    private TreeNode prev = null;
    private TreeNode successor = null;

    public TreeNode inorderSuccessor(TreeNode root, TreeNode p) {
        inorder(root, p);
        return successor;
    }

    private void inorder(TreeNode node, TreeNode p) {
        if (node == null) {
            return;
        }
        inorder(node.left, p);
        if (prev == p) {
            successor = node;
            return;
        }
        prev = node;
        inorder(node.right, p);
    }
}