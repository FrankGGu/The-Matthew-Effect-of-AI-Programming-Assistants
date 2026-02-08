public class Solution {
    public int findSecondMinimumValue(TreeNode root) {
        if (root == null || root.left == null) {
            return -1;
        }
        int[] result = new int[1];
        result[0] = -1;
        dfs(root, root.val, result);
        return result[0];
    }

    private void dfs(TreeNode node, int min, int[] result) {
        if (node == null) {
            return;
        }
        if (node.val > min && (result[0] == -1 || node.val < result[0])) {
            result[0] = node.val;
        }
        dfs(node.left, min, result);
        dfs(node.right, min, result);
    }
}