class Solution {
    private String smallest = null;

    public String smallestFromLeaf(TreeNode root) {
        dfs(root, new StringBuilder());
        return smallest;
    }

    private void dfs(TreeNode node, StringBuilder path) {
        if (node == null) return;

        path.append((char)('a' + node.val));

        if (node.left == null && node.right == null) {
            String current = path.reverse().toString();
            if (smallest == null || current.compareTo(smallest) < 0) {
                smallest = current;
            }
            path.reverse();
        }

        dfs(node.left, path);
        dfs(node.right, path);

        path.deleteCharAt(path.length() - 1);
    }
}