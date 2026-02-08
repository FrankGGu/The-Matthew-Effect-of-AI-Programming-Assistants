class Solution {
    public boolean isUnivalTree(TreeNode root) {
        if (root == null) return true;
        int val = root.val;
        return isUnivalTreeHelper(root, val);
    }

    private boolean isUnivalTreeHelper(TreeNode node, int val) {
        if (node == null) return true;
        if (node.val != val) return false;
        return isUnivalTreeHelper(node.left, val) && isUnivalTreeHelper(node.right, val);
    }
}