class Solution {
    int tiltSum = 0;

    public int findTilt(TreeNode root) {
        tiltSum = 0;
        calculateNodeSum(root);
        return tiltSum;
    }

    private int calculateNodeSum(TreeNode node) {
        if (node == null) {
            return 0;
        }

        int leftSum = calculateNodeSum(node.left);
        int rightSum = calculateNodeSum(node.right);

        tiltSum += Math.abs(leftSum - rightSum);

        return leftSum + rightSum + node.val;
    }
}