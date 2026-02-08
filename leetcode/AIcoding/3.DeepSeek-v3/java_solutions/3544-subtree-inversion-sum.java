class Solution {
    private int totalSum = 0;

    public int subtreeInversionSum(TreeNode root) {
        if (root == null) {
            return 0;
        }
        postOrder(root);
        return totalSum;
    }

    private int postOrder(TreeNode node) {
        if (node == null) {
            return 0;
        }
        int leftSum = postOrder(node.left);
        int rightSum = postOrder(node.right);
        int originalSum = node.val + leftSum + rightSum;
        int invertedSum = node.val + (node.left != null ? node.left.val : 0) + (node.right != null ? node.right.val : 0);
        totalSum += originalSum - invertedSum;
        return originalSum;
    }
}