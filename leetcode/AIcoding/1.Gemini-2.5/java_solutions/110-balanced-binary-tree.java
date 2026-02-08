class Solution {
    public boolean isBalanced(TreeNode root) {
        return checkHeightAndBalance(root) != -1;
    }

    private int checkHeightAndBalance(TreeNode node) {
        if (node == null) {
            return 0;
        }

        int leftHeight = checkHeightAndBalance(node.left);
        if (leftHeight == -1) {
            return -1;
        }

        int rightHeight = checkHeightAndBalance(node.right);
        if (rightHeight == -1) {
            return -1;
        }

        if (Math.abs(leftHeight - rightHeight) > 1) {
            return -1;
        }

        return 1 + Math.max(leftHeight, rightHeight);
    }
}