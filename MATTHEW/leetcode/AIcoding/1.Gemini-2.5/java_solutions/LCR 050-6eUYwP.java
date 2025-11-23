import java.util.HashMap;
import java.util.Map;

class Solution {
    private int count = 0;
    private Map<Long, Integer> prefixSumCount = new HashMap<>();
    private int targetSum;

    public int pathSum(TreeNode root, int targetSum) {
        this.targetSum = targetSum;
        prefixSumCount.put(0L, 1);
        dfs(root, 0L);
        return count;
    }

    private void dfs(TreeNode node, long currentSum) {
        if (node == null) {
            return;
        }

        currentSum += node.val;

        if (prefixSumCount.containsKey(currentSum - targetSum)) {
            count += prefixSumCount.get(currentSum - targetSum);
        }

        prefixSumCount.put(currentSum, prefixSumCount.getOrDefault(currentSum, 0) + 1);

        dfs(node.left, currentSum);
        dfs(node.right, currentSum);

        prefixSumCount.put(currentSum, prefixSumCount.get(currentSum) - 1);
    }
}