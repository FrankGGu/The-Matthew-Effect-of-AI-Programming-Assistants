class Solution {
    long totalSum = 0;
    long maxProduct = 0;
    long MOD = 1_000_000_007;

    public int maxProduct(TreeNode root) {
        calculateTotalSum(root);
        calculateSubtreeSumsAndProducts(root);
        return (int) (maxProduct % MOD);
    }

    private void calculateTotalSum(TreeNode node) {
        if (node == null) {
            return;
        }
        totalSum += node.val;
        calculateTotalSum(node.left);
        calculateTotalSum(node.right);
    }

    private long calculateSubtreeSumsAndProducts(TreeNode node) {
        if (node == null) {
            return 0;
        }

        long leftSubtreeSum = calculateSubtreeSumsAndProducts(node.left);
        long rightSubtreeSum = calculateSubtreeSumsAndProducts(node.right);

        long currentSubtreeSum = node.val + leftSubtreeSum + rightSubtreeSum;

        maxProduct = Math.max(maxProduct, currentSubtreeSum * (totalSum - currentSubtreeSum));

        return currentSubtreeSum;
    }
}