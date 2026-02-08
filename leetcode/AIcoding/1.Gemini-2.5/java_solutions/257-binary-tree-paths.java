import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> binaryTreePaths(TreeNode root) {
        List<String> paths = new ArrayList<>();
        if (root == null) {
            return paths;
        }
        dfs(root, "", paths);
        return paths;
    }

    private void dfs(TreeNode node, String currentPath, List<String> paths) {
        if (node == null) {
            return;
        }

        String newPath = currentPath.isEmpty() ? String.valueOf(node.val) : currentPath + "->" + node.val;

        if (node.left == null && node.right == null) {
            paths.add(newPath);
            return;
        }

        dfs(node.left, newPath, paths);
        dfs(node.right, newPath, paths);
    }
}