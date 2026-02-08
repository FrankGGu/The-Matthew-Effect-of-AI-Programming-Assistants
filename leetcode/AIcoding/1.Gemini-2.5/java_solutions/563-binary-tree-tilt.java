class Solution {
    int totalTilt = 0;

    public int findTilt(TreeNode root) {
        totalTilt = 0;
        postOrderSumAndTilt(root);
        return totalTilt;
    }

    private int postOrderSumAndTilt(TreeNode node) {
        if (node == null) {
            return 0;
        }

        int leftSum = postOrderSumAndTilt(node.left);
        int rightSum = postOrderSumAndTilt(node.right);

        totalTilt += Math.abs(leftSum - rightSum);

        return node.val + leftSum + rightSum;
    }
}