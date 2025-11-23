public class Solution {
    private int totalSum = 0;
    private int maxProduct = 0;

    public int maxProduct(TreeNode root) {
        totalSum = dfs(root);
        dfs(root);
        return maxProduct;
    }

    private int dfs(TreeNode node) {
        if (node == null) return 0;
        int sum = node.val + dfs(node.left) + dfs(node.right);
        if (totalSum != 0) {
            maxProduct = Math.max(maxProduct, sum * (totalSum - sum));
        }
        return sum;
    }

    static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;
        TreeNode(int x) { val = x; }
    }
}