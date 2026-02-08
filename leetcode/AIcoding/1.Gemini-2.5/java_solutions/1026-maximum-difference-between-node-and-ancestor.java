class Solution {
    public int maxAncestorDiff(TreeNode root) {
        if (root == null) {
            return 0;
        }
        return dfs(root, root.val, root.val);
    }

    private int dfs(TreeNode node, int minAncestor, int maxAncestor) {
        if (node == null) {
            return 0;
        }

        int currentMaxDiff = Math.max(Math.abs(node.val - minAncestor), Math.abs(node.val - maxAncestor));

        int newMin = Math.min(minAncestor, node.val);
        int newMax = Math.max(maxAncestor, node.val);

        int leftSubtreeDiff = dfs(node.left, newMin, newMax);
        int rightSubtreeDiff = dfs(node.right, newMin, newMax);

        return Math.max(currentMaxDiff, Math.max(leftSubtreeDiff, rightSubtreeDiff));
    }
}