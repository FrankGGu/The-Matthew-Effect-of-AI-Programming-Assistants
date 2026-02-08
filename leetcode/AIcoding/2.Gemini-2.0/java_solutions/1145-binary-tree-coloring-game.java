class Solution {
    int left, right, n;
    public boolean btreeGameWinningMove(TreeNode root, int n, int x) {
        this.n = n;
        findNode(root, x);
        return Math.max(Math.max(left, right), n - left - right - 1) > n / 2;
    }

    private int findNode(TreeNode root, int x) {
        if (root == null) return 0;
        int l = findNode(root.left, x);
        int r = findNode(root.right, x);
        if (root.val == x) {
            left = l;
            right = r;
        }
        return l + r + 1;
    }
}