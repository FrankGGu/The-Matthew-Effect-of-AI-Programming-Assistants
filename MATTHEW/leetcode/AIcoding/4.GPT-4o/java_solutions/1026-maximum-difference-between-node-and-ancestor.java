class Solution {
    private int maxDiff = 0;

    public int maxAncestorDiff(TreeNode root) {
        if (root == null) return 0;
        dfs(root, root.val, root.val);
        return maxDiff;
    }

    private void dfs(TreeNode node, int minVal, int maxVal) {
        if (node == null) return;
        minVal = Math.min(minVal, node.val);
        maxVal = Math.max(maxVal, node.val);
        maxDiff = Math.max(maxDiff, maxVal - minVal);
        dfs(node.left, minVal, maxVal);
        dfs(node.right, minVal, maxVal);
    }
}