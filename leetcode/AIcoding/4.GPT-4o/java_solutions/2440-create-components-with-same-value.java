class Solution {
    private int count;

    public int componentCount(TreeNode root, int x) {
        int total = dfs(root);
        count = 0;
        dfsCount(root, total, x);
        return count;
    }

    private int dfs(TreeNode node) {
        if (node == null) return 0;
        return node.val + dfs(node.left) + dfs(node.right);
    }

    private boolean dfsCount(TreeNode node, int total, int x) {
        if (node == null) return false;
        int sum = node.val + (dfsCount(node.left, total, x) ? 0 : 0) + (dfsCount(node.right, total, x) ? 0 : 0);
        if (sum == x) {
            count++;
            return true;
        }
        return false;
    }
}