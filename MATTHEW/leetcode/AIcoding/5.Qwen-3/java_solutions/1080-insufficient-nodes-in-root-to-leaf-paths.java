public class Solution {

class Solution {
    public TreeNode sufficientSubset(TreeNode root, int limit) {
        return dfs(root, 0, limit);
    }

    private TreeNode dfs(TreeNode node, int currentSum, int limit) {
        if (node == null) {
            return null;
        }
        currentSum += node.val;
        if (node.left == null && node.right == null) {
            return currentSum < limit ? null : node;
        }
        node.left = dfs(node.left, currentSum, limit);
        node.right = dfs(node.right, currentSum, limit);
        return (node.left != null || node.right != null) ? node : null;
    }

    static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;
        TreeNode() {}
        TreeNode(int val) { this.val = val; }
        TreeNode(int val, TreeNode left, TreeNode right) {
            this.val = val;
            this.left = left;
            this.right = right;
        }
    }
}
}