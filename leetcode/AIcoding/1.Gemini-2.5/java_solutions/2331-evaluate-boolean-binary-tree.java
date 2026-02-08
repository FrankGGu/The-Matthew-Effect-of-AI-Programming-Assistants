class Solution {
    public boolean evaluateTree(TreeNode root) {
        if (root.val == 0) {
            return false;
        }
        if (root.val == 1) {
            return true;
        }

        boolean leftResult = evaluateTree(root.left);
        boolean rightResult = evaluateTree(root.right);

        if (root.val == 2) { // OR operation
            return leftResult || rightResult;
        } else { // root.val == 3, AND operation
            return leftResult && rightResult;
        }
    }
}