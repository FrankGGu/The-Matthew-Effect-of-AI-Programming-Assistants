class Solution {
    public int pathSum(TreeNode root, int targetSum) {
        if (root == null) {
            return 0;
        }
        return dfs(root, targetSum) + pathSum(root.left, targetSum) + pathSum(root.right, targetSum);
    }

    private int dfs(TreeNode node, long targetSum) {
        if (node == null) {
            return 0;
        }
        int count = 0;
        if (node.val == targetSum) {
            count++;
        }
        count += dfs(node.left, targetSum - node.val);
        count += dfs(node.right, targetSum - node.val);
        return count;
    }
}