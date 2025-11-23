class Solution {
    private int leftSubtreeSize;
    private int rightSubtreeSize;

    public boolean btreeGameWinningStrategy(TreeNode root, int n, int x) {
        findXAndCalculateSubtreeSizes(root, x);

        int parentRegionSize = n - 1 - leftSubtreeSize - rightSubtreeSize;

        if (leftSubtreeSize > n / 2 || rightSubtreeSize > n / 2 || parentRegionSize > n / 2) {
            return true;
        }
        return false;
    }

    private int findXAndCalculateSubtreeSizes(TreeNode node, int x) {
        if (node == null) {
            return 0;
        }

        int leftCount = findXAndCalculateSubtreeSizes(node.left, x);
        int rightCount = findXAndCalculateSubtreeSizes(node.right, x);

        if (node.val == x) {
            leftSubtreeSize = leftCount;
            rightSubtreeSize = rightCount;
        }

        return 1 + leftCount + rightCount;
    }
}