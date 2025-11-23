public class Solution {


import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int pathSum(TreeNode root, int targetSum) {
        Map<Long, Integer> prefixSumCount = new HashMap<>();
        prefixSumCount.put(0L, 1);
        return dfs(root, targetSum, 0L, prefixSumCount);
    }

    private int dfs(TreeNode node, int targetSum, long currentSum, Map<Long, Integer> prefixSumCount) {
        if (node == null) {
            return 0;
        }

        currentSum += node.val;
        int count = prefixSumCount.getOrDefault(currentSum - targetSum, 0);
        prefixSumCount.put(currentSum, prefixSumCount.getOrDefault(currentSum, 0) + 1);

        int leftCount = dfs(node.left, targetSum, currentSum, prefixSumCount);
        int rightCount = dfs(node.right, targetSum, currentSum, prefixSumCount);

        prefixSumCount.put(currentSum, prefixSumCount.get(currentSum) - 1);

        return count + leftCount + rightCount;
    }
}
}