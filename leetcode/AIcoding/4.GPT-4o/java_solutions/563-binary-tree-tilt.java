class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

public class Solution {
    private int tilt = 0;

    public int findTilt(TreeNode root) {
        calculateSum(root);
        return tilt;
    }

    private int calculateSum(TreeNode node) {
        if (node == null) return 0;
        int leftSum = calculateSum(node.left);
        int rightSum = calculateSum(node.right);
        tilt += Math.abs(leftSum - rightSum);
        return leftSum + rightSum + node.val;
    }
}