import java.util.HashSet;

public class Solution {
    public int minCameraCover(TreeNode root) {
        if (root == null) return 0;
        HashSet<TreeNode> monitored = new HashSet<>();
        monitored.add(null);
        return dfs(root, monitored);
    }

    private int dfs(TreeNode node, HashSet<TreeNode> monitored) {
        if (node == null) return 1;

        int left = dfs(node.left, monitored);
        int right = dfs(node.right, monitored);

        if (left == 1 && right == 1) {
            return 0;
        } else if (left == 0 || right == 0) {
            monitored.add(node);
            return 2;
        } else {
            return 1;
        }
    }
}