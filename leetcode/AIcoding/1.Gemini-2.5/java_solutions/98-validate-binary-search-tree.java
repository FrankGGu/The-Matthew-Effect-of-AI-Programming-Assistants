class Solution {
    public boolean isValidBST(TreeNode root) {
        return isValidBST(root, null, null);
    }

    private boolean isValidBST(TreeNode node, Long minVal, Long maxVal) {
        if (node == null) {
            return true;
        }

        if (minVal != null && node.val <= minVal) {
            return false;
        }
        if (maxVal != null && node.val >= maxVal) {
            return false;
        }

        return isValidBST(node.left, minVal, (long)node.val) &&
               isValidBST(node.right, (long)node.val, maxVal);
    }
}