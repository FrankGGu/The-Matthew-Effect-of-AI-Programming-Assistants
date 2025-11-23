public class Solution {
    int maxSum = 0;

    public class BSTInfo {
        boolean isBST;
        int minVal;
        int maxVal;
        int sum;

        public BSTInfo(boolean isBST, int minVal, int maxVal, int sum) {
            this.isBST = isBST;
            this.minVal = minVal;
            this.maxVal = maxVal;
            this.sum = sum;
        }
    }

    public int maxSumBST(TreeNode root) {
        helper(root);
        return maxSum;
    }

    private BSTInfo helper(TreeNode node) {
        if (node == null) {
            return new BSTInfo(true, Integer.MAX_VALUE, Integer.MIN_VALUE, 0);
        }

        BSTInfo left = helper(node.left);
        BSTInfo right = helper(node.right);

        if (left.isBST && right.isBST && node.val > left.maxVal && node.val < right.minVal) {
            int currentSum = left.sum + right.sum + node.val;
            maxSum = Math.max(maxSum, currentSum);
            return new BSTInfo(true, Math.min(node.val, left.minVal), Math.max(node.val, right.maxVal), currentSum);
        } else {
            return new BSTInfo(false, 0, 0, 0);
        }
    }
}