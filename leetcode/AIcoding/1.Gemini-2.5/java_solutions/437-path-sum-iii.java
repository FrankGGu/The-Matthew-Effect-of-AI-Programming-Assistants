import java.util.HashMap;
import java.util.Map;

class Solution {
    int count = 0;
    Map<Long, Integer> prefixSumCounts;

    public int pathSum(TreeNode root, int targetSum) {
        count = 0;
        prefixSumCounts = new HashMap<>();
        prefixSumCounts.put(0L, 1);

        dfs(root, targetSum, 0L);
        return count;
    }

    private void dfs(TreeNode node, int targetSum, long currentSum) {
        if (node == null) {
            return;
        }

        currentSum += node.val;

        if (prefixSumCounts.containsKey(currentSum - (long)targetSum)) {
            count += prefixSumCounts.get(currentSum - (long)targetSum);
        }

        prefixSumCounts.put(currentSum, prefixSumCounts.getOrDefault(currentSum, 0) + 1);

        dfs(node.left, targetSum, currentSum);
        dfs(node.right, targetSum, currentSum);

        prefixSumCounts.put(currentSum, prefixSumCounts.get(currentSum) - 1);
    }
}