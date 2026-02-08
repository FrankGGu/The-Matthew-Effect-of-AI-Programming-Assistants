class Solution {
    private long totalSum;
    private long maxProduct;

    public int maxProduct(TreeNode root) {
        totalSum = getSum(root);
        maxProduct = 0;
        getMaxProduct(root);
        return (int) (maxProduct % 1000000007);
    }

    private long getSum(TreeNode node) {
        if (node == null) return 0;
        return node.val + getSum(node.left) + getSum(node.right);
    }

    private long getMaxProduct(TreeNode node) {
        if (node == null) return 0;
        long leftSum = getMaxProduct(node.left);
        long rightSum = getMaxProduct(node.right);
        long currentSum = node.val + leftSum + rightSum;
        maxProduct = Math.max(maxProduct, currentSum * (totalSum - currentSum));
        return currentSum;
    }
}