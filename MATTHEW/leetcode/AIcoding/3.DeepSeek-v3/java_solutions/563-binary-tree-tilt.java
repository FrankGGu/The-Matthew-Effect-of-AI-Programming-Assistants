class Solution {
    private int totalTilt = 0;

    public int findTilt(TreeNode root) {
        calculateSum(root);
        return totalTilt;
    }

    private int calculateSum(TreeNode node) {
        if (node == null) {
            return 0;
        }
        int leftSum = calculateSum(node.left);
        int rightSum = calculateSum(node.right);
        int tilt = Math.abs(leftSum - rightSum);
        totalTilt += tilt;
        return node.val + leftSum + rightSum;
    }
}