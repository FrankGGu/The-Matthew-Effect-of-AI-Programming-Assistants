public class Solution {

class Solution {
    public int pseudoPalindromes(TreeNode root) {
        return dfs(root, 0);
    }

    private int dfs(TreeNode node, int path) {
        if (node == null) return 0;
        path ^= 1 << (node.val - 1);
        if (node.left == null && node.right == null) {
            return (path & (path - 1)) == 0 ? 1 : 0;
        }
        return dfs(node.left, path) + dfs(node.right, path);
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