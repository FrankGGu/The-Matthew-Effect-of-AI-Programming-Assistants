class Solution {
    int leftSize = 0;
    int rightSize = 0;

    public boolean btreeGameWinningMove(TreeNode root, int n, int x) {
        findNode(root, x);
        return Math.max(n - 1 - leftSize - rightSize, Math.max(leftSize, rightSize)) > n / 2;
    }

    private int findNode(TreeNode root, int x) {
        if (root == null) {
            return 0;
        }
        int left = findNode(root.left, x);
        int right = findNode(root.right, x);
        if (root.val == x) {
            leftSize = left;
            rightSize = right;
        }
        return left + right + 1;
    }
}