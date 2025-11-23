class Solution {
    public boolean isValidBST(TreeNode root) {
        return isValidBSTHelper(root, null, null);
    }

    private boolean isValidBSTHelper(TreeNode node, Integer lower, Integer upper) {
        if (node == null) {
            return true;
        }

        int val = node.val;
        if (lower != null && val <= lower) {
            return false;
        }
        if (upper != null && val >= upper) {
            return false;
        }

        if (!isValidBSTHelper(node.right, val, upper)) {
            return false;
        }
        if (!isValidBSTHelper(node.left, lower, val)) {
            return false;
        }
        return true;
    }
}