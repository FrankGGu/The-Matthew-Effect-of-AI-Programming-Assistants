class Solution {
    private long totalSum = 0;
    private long maxProduct = 0;

    public int maxProduct(TreeNode root) {
        totalSum = getSum(root);
        getSum(root);
        return (int)(maxProduct % (1e9 + 7));
    }

    private long getSum(TreeNode node) {
        if (node == null) return 0;
        long sum = node.val + getSum(node.left) + getSum(node.right);
        maxProduct = Math.max(maxProduct, sum * (totalSum - sum));
        return sum;
    }
}