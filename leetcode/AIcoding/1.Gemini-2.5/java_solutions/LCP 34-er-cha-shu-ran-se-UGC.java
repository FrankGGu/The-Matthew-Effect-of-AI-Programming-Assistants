class Solution {
    private int leftSubtreeSize;
    private int rightSubtreeSize;

    public boolean btreeGameWinningMove(TreeNode root, int n, int x) {
        dfs(root, x);

        int parentPartSize = n - 1 - leftSubtreeSize - rightSubtreeSize;

        return leftSubtreeSize > n / 2 || rightSubtreeSize > n / 2 || parentPartSize > n / 2;
    }

    private int dfs(TreeNode node, int x) {
        if (node == null) {
            return 0;
        }

        int leftCount = dfs(node.left, x);
        int rightCount = dfs(node.right, x);

        if (node.val == x) {
            leftSubtreeSize = leftCount;
            rightSubtreeSize = rightCount;
        }

        return 1 + leftCount + rightCount;
    }
}