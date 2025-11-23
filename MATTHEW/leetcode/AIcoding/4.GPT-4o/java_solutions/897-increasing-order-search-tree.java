class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

class Solution {
    TreeNode prev = null;
    TreeNode newRoot = null;

    public TreeNode increasingBST(TreeNode root) {
        newRoot = new TreeNode(0);
        prev = newRoot;
        inorder(root);
        return newRoot.right;
    }

    private void inorder(TreeNode node) {
        if (node == null) return;
        inorder(node.left);
        node.left = null;
        prev.right = node;
        prev = node;
        inorder(node.right);
    }
}