class Solution {
    public boolean isUnivalTree(TreeNode root) {
        if (root == null) {
            return true;
        }
        return checkUnival(root, root.val);
    }

    private boolean checkUnival(TreeNode node, int expectedVal) {
        if (node == null) {
            return true;
        }
        if (node.val != expectedVal) {
            return false;
        }
        return checkUnival(node.left, expectedVal) && checkUnival(node.right, expectedVal);
    }
}