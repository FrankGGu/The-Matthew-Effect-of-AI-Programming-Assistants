public class Solution {
    public int sumNumbers(TreeNode root) {
        return sumNumbers(root, 0);
    }

    private int sumNumbers(TreeNode root, int currentSum) {
        if (root == null) {
            return 0;
        }
        currentSum = currentSum * 10 + root.val;
        if (root.left == null && root.right == null) {
            return currentSum;
        }
        return sumNumbers(root.left, currentSum) + sumNumbers(root.right, currentSum);
    }

    static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode(int x) {
            val = x;
        }
    }
}