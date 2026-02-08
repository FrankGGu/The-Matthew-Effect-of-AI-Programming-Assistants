class Solution {
    private int leftCount = 0;
    private int rightCount = 0;
    private int totalCount = 0;

    public boolean btreeGameWinningMove(TreeNode root, int n, int x) {
        totalCount = n;
        countNodes(root, x);
        return Math.max(leftCount, Math.max(rightCount, totalCount - (leftCount + rightCount + 1))) > totalCount / 2;
    }

    private int countNodes(TreeNode node, int x) {
        if (node == null) return 0;
        int count = 1;
        if (node.val == x) {
            leftCount = countNodes(node.left, x);
            rightCount = countNodes(node.right, x);
        } else {
            count += countNodes(node.left, x);
            count += countNodes(node.right, x);
        }
        return count;
    }
}