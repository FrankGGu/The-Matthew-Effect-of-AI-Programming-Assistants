public class Solution {
    int tilt = 0;

    public int findTilt(TreeNode root) {
        helper(root);
        return tilt;
    }

    private int helper(TreeNode node) {
        if (node == null) {
            return 0;
        }
        int left = helper(node.left);
        int right = helper(node.right);
        tilt += Math.abs(left - right);
        return left + right + node.val;
    }
}