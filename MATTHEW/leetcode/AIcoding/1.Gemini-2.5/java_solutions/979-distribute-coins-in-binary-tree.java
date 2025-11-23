class Solution {
    int totalMoves;

    public int distributeCoins(TreeNode root) {
        totalMoves = 0;
        dfs(root);
        return totalMoves;
    }

    private int dfs(TreeNode node) {
        if (node == null) {
            return 0;
        }

        int leftExcess = dfs(node.left);
        int rightExcess = dfs(node.right);

        totalMoves += Math.abs(leftExcess);
        totalMoves += Math.abs(rightExcess);

        return node.val + leftExcess + rightExcess - 1;
    }
}