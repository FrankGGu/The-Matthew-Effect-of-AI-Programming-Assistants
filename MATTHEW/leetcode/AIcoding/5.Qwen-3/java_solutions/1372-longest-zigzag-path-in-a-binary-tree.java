public class Solution {
    int maxPath;

    public int longestZigZag(TreeNode root) {
        dfs(root, false, 0);
        return maxPath;
    }

    private int dfs(TreeNode node, boolean isLeft, int length) {
        if (node == null) {
            return length;
        }
        int left = dfs(node.left, true, isLeft ? length + 1 : 1);
        int right = dfs(node.right, false, !isLeft ? length + 1 : 1);
        maxPath = Math.max(maxPath, Math.max(left, right));
        return Math.max(left, right);
    }
}