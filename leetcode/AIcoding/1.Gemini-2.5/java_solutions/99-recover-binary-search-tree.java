class Solution {
    private TreeNode first;
    private TreeNode second;
    private TreeNode prev;

    public void recoverTree(TreeNode root) {
        first = null;
        second = null;
        prev = null; 

        inorder(root);

        int temp = first.val;
        first.val = second.val;
        second.val = temp;
    }

    private void inorder(TreeNode node) {
        if (node == null) {
            return;
        }

        inorder(node.left);

        if (prev != null && prev.val > node.val) {
            if (first == null) {
                first = prev;
            }
            second = node;
        }
        prev = node;

        inorder(node.right);
    }
}