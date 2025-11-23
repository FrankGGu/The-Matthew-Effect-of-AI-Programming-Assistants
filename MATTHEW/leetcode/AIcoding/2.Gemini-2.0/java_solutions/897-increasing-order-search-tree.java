class Solution {
    private TreeNode prev;
    private TreeNode head;

    public TreeNode increasingBST(TreeNode root) {
        prev = null;
        head = null;
        inorder(root);
        return head;
    }

    private void inorder(TreeNode root) {
        if (root == null) {
            return;
        }

        inorder(root.left);

        if (prev != null) {
            prev.right = root;
        } else {
            head = root;
        }

        root.left = null;
        prev = root;

        inorder(root.right);
    }
}