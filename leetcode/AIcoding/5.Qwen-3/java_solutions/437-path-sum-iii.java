public class Solution {
    public int pathSum(TreeNode root, int targetSum) {
        return dfs(root, targetSum, new java.util.HashMap<>(), 0);
    }

    private int dfs(TreeNode node, int targetSum, java.util.HashMap<Long, Integer> prefixCounts, long currentSum) {
        if (node == null) {
            return 0;
        }

        currentSum += node.val;
        int count = prefixCounts.getOrDefault(currentSum - targetSum, 0);

        prefixCounts.put(currentSum, prefixCounts.getOrDefault(currentSum, 0) + 1);

        count += dfs(node.left, targetSum, prefixCounts, currentSum);
        count += dfs(node.right, targetSum, prefixCounts, currentSum);

        prefixCounts.put(currentSum, prefixCounts.get(currentSum) - 1);
        if (prefixCounts.get(currentSum) == 0) {
            prefixCounts.remove(currentSum);
        }

        return count;
    }
}