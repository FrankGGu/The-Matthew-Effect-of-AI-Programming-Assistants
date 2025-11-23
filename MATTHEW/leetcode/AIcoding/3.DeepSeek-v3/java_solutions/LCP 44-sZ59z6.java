class Solution {
    public int numColor(TreeNode root) {
        Set<Integer> colors = new HashSet<>();
        dfs(root, colors);
        return colors.size();
    }

    private void dfs(TreeNode node, Set<Integer> colors) {
        if (node == null) {
            return;
        }
        colors.add(node.val);
        dfs(node.left, colors);
        dfs(node.right, colors);
    }
}