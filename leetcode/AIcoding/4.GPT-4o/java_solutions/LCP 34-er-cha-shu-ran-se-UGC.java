class Solution {
    public boolean btreeGameWinningMove(TreeNode root, int n, int x) {
        int[] count = new int[1];
        countNodes(root, x, count);
        int left = count[0];
        count[0] = 0;
        int right = countNodes(root, x, count);
        int total = left + right + 1;
        return Math.max(left, Math.max(right, n - total)) > n / 2;
    }

    private int countNodes(TreeNode node, int x, int[] count) {
        if (node == null) {
            return 0;
        }
        if (node.val == x) {
            count[0] = countNodes(node.left, x, count) + countNodes(node.right, x, count);
            return count[0];
        }
        return 1 + countNodes(node.left, x, count) + countNodes(node.right, x, count);
    }
}