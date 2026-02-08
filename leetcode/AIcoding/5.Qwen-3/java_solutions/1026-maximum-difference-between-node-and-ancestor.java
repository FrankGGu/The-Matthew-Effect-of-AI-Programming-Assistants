public class Solution {
    private int maxDiff;

    public int maxAncestorDiff(TreeNode root) {
        maxDiff = 0;
        dfs(root, root.val, root.val);
        return maxDiff;
    }

    private void dfs(TreeNode node, int minVal, int maxVal) {
        if (node == null) {
            return;
        }
        maxDiff = Math.max(maxDiff, Math.abs(node.val - minVal));
        maxDiff = Math.max(maxDiff, Math.abs(node.val - maxVal));
        dfs(node.left, Math.min(minVal, node.val), Math.max(maxVal, node.val));
        dfs(node.right, Math.min(minVal, node.val), Math.max(maxVal, node.val));
    }
}