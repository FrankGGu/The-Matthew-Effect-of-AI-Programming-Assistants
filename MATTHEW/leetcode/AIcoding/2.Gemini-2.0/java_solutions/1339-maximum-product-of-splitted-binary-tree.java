class Solution {
    long totalSum = 0;
    long maxProduct = 0;

    public int maxProduct(TreeNode root) {
        totalSum = treeSum(root);
        treeSumHelper(root);
        return (int) (maxProduct % 1000000007);
    }

    private long treeSum(TreeNode root) {
        if (root == null) return 0;
        return root.val + treeSum(root.left) + treeSum(root.right);
    }

    private long treeSumHelper(TreeNode root) {
        if (root == null) return 0;

        long leftSum = treeSumHelper(root.left);
        long rightSum = treeSumHelper(root.right);

        long currentSum = root.val + leftSum + rightSum;

        maxProduct = Math.max(maxProduct, (totalSum - currentSum) * currentSum);

        return currentSum;
    }
}