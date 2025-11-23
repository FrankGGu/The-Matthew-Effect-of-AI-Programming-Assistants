import java.util.HashMap;

public class Solution {
    private int count = 0;

    public int pathSum(TreeNode root, int targetSum) {
        HashMap<Long, Integer> prefixSumCount = new HashMap<>();
        prefixSumCount.put(0L, 1);
        dfs(root, 0, targetSum, prefixSumCount);
        return count;
    }

    private void dfs(TreeNode node, long currentSum, int targetSum, HashMap<Long, Integer> prefixSumCount) {
        if (node == null) return;

        currentSum += node.val;
        count += prefixSumCount.getOrDefault(currentSum - targetSum, 0);

        prefixSumCount.put(currentSum, prefixSumCount.getOrDefault(currentSum, 0) + 1);

        dfs(node.left, currentSum, targetSum, prefixSumCount);
        dfs(node.right, currentSum, targetSum, prefixSumCount);

        prefixSumCount.put(currentSum, prefixSumCount.get(currentSum) - 1);
    }
}

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}