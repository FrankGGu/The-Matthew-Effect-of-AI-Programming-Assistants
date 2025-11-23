class Solution {
    public TreeNode expandBinaryTree(TreeNode root) {
        if (root == null) {
            return null;
        }
        if (root.left != null) {
            TreeNode left = root.left;
            root.left = new TreeNode(-1);
            root.left.left = expandBinaryTree(left);
        }
        if (root.right != null) {
            TreeNode right = root.right;
            root.right = new TreeNode(-1);
            root.right.right = expandBinaryTree(right);
        }
        return root;
    }
}