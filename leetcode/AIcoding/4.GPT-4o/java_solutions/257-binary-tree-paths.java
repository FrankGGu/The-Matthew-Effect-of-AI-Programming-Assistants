import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> binaryTreePaths(TreeNode root) {
        List<String> paths = new ArrayList<>();
        if (root != null) {
            constructPaths(root, "", paths);
        }
        return paths;
    }

    private void constructPaths(TreeNode root, String path, List<String> paths) {
        path += Integer.toString(root.val);
        if (root.left == null && root.right == null) {
            paths.add(path); // if it's a leaf
        } else {
            path += "->"; // extend the path
            if (root.left != null) constructPaths(root.left, path, paths);
            if (root.right != null) constructPaths(root.right, path, paths);
        }
    }
}

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}