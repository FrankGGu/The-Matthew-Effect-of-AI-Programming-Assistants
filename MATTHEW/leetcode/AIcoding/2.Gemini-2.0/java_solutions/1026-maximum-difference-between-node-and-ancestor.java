class Solution {
    public int maxAncestorDiff(TreeNode root) {
        return dfs(root, root.val, root.val);
    }

    private int dfs(TreeNode node, int maxAncestor, int minAncestor) {
        if (node == null) {
            return 0;
        }

        maxAncestor = Math.max(maxAncestor, node.val);
        minAncestor = Math.min(minAncestor, node.val);

        int leftDiff = dfs(node.left, maxAncestor, minAncestor);
        int rightDiff = dfs(node.right, maxAncestor, minAncestor);

        return Math.max(Math.max(leftDiff, rightDiff), maxAncestor - minAncestor);
    }
}