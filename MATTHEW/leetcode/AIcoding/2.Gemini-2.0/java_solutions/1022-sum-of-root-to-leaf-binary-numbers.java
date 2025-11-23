class Solution {
    public int sumRootToLeaf(TreeNode root) {
        return sumRootToLeafHelper(root, 0);
    }

    private int sumRootToLeafHelper(TreeNode node, int currentSum) {
        if (node == null) {
            return 0;
        }

        currentSum = (currentSum << 1) | node.val;

        if (node.left == null && node.right == null) {
            return currentSum;
        }

        return sumRootToLeafHelper(node.left, currentSum) + sumRootToLeafHelper(node.right, currentSum);
    }
}