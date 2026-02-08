class Solution {
    public int pseudoPalindromicPaths (TreeNode root) {
        return dfs(root, 0);
    }

    private int dfs(TreeNode node, int count) {
        if (node == null) return 0;
        count ^= (1 << node.val);
        if (node.left == null && node.right == null) {
            return (count & (count - 1)) == 0 ? 1 : 0;
        }
        return dfs(node.left, count) + dfs(node.right, count);
    }
}