public class Solution {
    public int rob(TreeNode root) {
        return robHelper(root)[0];
    }

    private int[] robHelper(TreeNode node) {
        if (node == null) {
            return new int[]{0, 0};
        }

        int[] left = robHelper(node.left);
        int[] right = robHelper(node.right);

        int rob = node.val + left[1] + right[1];
        int notRob = Math.max(left[0], left[1]) + Math.max(right[0], right[1]);

        return new int[]{rob, notRob};
    }

    static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode() {}

        TreeNode(int val) {
            this.val = val;
        }

        TreeNode(int val, TreeNode left, TreeNode right) {
            this.val = val;
            this.left = left;
            this.right = right;
        }
    }
}