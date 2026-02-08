public class Solution {
    private int minDiff = Integer.MAX_VALUE;
    private TreeNode prev = null;

    public int minDiffInBST(TreeNode root) {
        inorderTraversal(root);
        return minDiff;
    }

    private void inorderTraversal(TreeNode node) {
        if (node == null) {
            return;
        }
        inorderTraversal(node.left);
        if (prev != null) {
            minDiff = Math.min(minDiff, node.val - prev.val);
        }
        prev = node;
        inorderTraversal(node.right);
    }
}