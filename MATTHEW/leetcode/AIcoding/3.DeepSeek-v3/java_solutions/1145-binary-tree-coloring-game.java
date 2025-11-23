class Solution {
    private int leftCount, rightCount;

    public boolean btreeGameWinningMove(TreeNode root, int n, int x) {
        countNodes(root, x);
        int parentCount = n - leftCount - rightCount - 1;
        return Math.max(parentCount, Math.max(leftCount, rightCount)) > n / 2;
    }

    private int countNodes(TreeNode node, int x) {
        if (node == null) return 0;
        int left = countNodes(node.left, x);
        int right = countNodes(node.right, x);
        if (node.val == x) {
            leftCount = left;
            rightCount = right;
        }
        return left + right + 1;
    }
}