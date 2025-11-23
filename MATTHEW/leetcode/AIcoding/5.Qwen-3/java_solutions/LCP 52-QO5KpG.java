public class Solution {
    public int[] getColors(TreeNode root, int[] queries) {
        int[] result = new int[queries.length];
        int index = 0;
        for (int query : queries) {
            result[index++] = dfs(root, query);
        }
        return result;
    }

    private int dfs(TreeNode node, int target) {
        if (node == null) {
            return -1;
        }
        if (node.val == target) {
            return node.color;
        } else if (node.val < target) {
            return dfs(node.right, target);
        } else {
            return dfs(node.left, target);
        }
    }

    static class TreeNode {
        int val;
        int color;
        TreeNode left;
        TreeNode right;

        TreeNode(int val) {
            this.val = val;
            this.color = 0;
        }
    }
}