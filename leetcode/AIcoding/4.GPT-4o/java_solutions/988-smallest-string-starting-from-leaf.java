class Solution {
    public String smallestFromLeaf(TreeNode root) {
        List<String> paths = new ArrayList<>();
        dfs(root, "", paths);
        Collections.sort(paths);
        return paths.isEmpty() ? "" : paths.get(0);
    }

    private void dfs(TreeNode node, String path, List<String> paths) {
        if (node == null) return;
        path = (char)(node.val + 'a') + path;
        if (node.left == null && node.right == null) {
            paths.add(path);
        } else {
            dfs(node.left, path, paths);
            dfs(node.right, path, paths);
        }
    }
}