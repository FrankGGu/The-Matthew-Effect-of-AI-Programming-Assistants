public class Solution {
    int max;

    public int longestUnivaluePath(TreeNode root) {
        max = 0;
        dfs(root);
        return max;
    }

    private int dfs(TreeNode root) {
        if (root == null) {
            return 0;
        }
        int left = dfs(root.left);
        int right = dfs(root.right);
        int leftVal = (root.left != null && root.left.val == root.val) ? left + 1 : 0;
        int rightVal = (root.right != null && root.right.val == root.val) ? right + 1 : 0;
        max = Math.max(max, leftVal + rightVal);
        return Math.max(leftVal, rightVal);
    }

    static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;
        TreeNode(int x) { val = x; }
    }
}