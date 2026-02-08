class Solution {
    public int subtreeSum(TreeNode root) {
        if (root == null) return 0;
        return root.val + subtreeSum(root.left) + subtreeSum(root.right);
    }

    public int maxInvertedSum(TreeNode root) {
        if (root == null) return 0;
        int leftSum = subtreeSum(root.left);
        int rightSum = subtreeSum(root.right);
        return Math.max(root.val + leftSum + rightSum, Math.max(maxInvertedSum(root.left), maxInvertedSum(root.right)));
    }

    public int maxInvertedSubtreeSum(TreeNode root) {
        return maxInvertedSum(root);
    }
}