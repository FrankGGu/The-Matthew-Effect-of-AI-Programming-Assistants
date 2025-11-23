class Solution {
    int minDiff = Integer.MAX_VALUE;
    int prevVal = -1; 

    public int minDiffInBST(TreeNode root) {
        inorderTraversal(root);
        return minDiff;
    }

    private void inorderTraversal(TreeNode node) {
        if (node == null) {
            return;
        }

        inorderTraversal(node.left);

        if (prevVal != -1) {
            minDiff = Math.min(minDiff, node.val - prevVal);
        }
        prevVal = node.val;

        inorderTraversal(node.right);
    }
}