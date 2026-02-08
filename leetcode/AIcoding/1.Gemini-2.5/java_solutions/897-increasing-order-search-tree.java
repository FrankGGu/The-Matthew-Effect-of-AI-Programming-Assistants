class Solution {
    TreeNode head = null;
    TreeNode prev = null;

    public TreeNode increasingBST(TreeNode root) {
        inorder(root);
        return head;
    }

    private void inorder(TreeNode node) {
        if (node == null) {
            return;
        }

        inorder(node.left);

        node.left = null;
        if (prev != null) {
            prev.right = node;
        } else {
            head = node;
        }
        prev = node;

        inorder(node.right);
    }
}