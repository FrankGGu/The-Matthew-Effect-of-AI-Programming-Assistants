class Solution {
    public TreeNode increasingBST(TreeNode root) {
        TreeNode dummy = new TreeNode(0);
        TreeNode current = dummy;
        inOrderTraversal(root, current);
        return dummy.right;
    }

    private void inOrderTraversal(TreeNode node, TreeNode current) {
        if (node == null) return;
        inOrderTraversal(node.left, current);
        current.right = new TreeNode(node.val);
        current = current.right;
        inOrderTraversal(node.right, current);
    }
}