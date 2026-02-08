import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    private Map<Integer, Integer> sumCounts;
    private int maxFreq;

    public int[] findFrequentTreeSum(TreeNode root) {
        sumCounts = new HashMap<>();
        maxFreq = 0;

        dfs(root);

        List<Integer> resultList = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : sumCounts.entrySet()) {
            if (entry.getValue() == maxFreq) {
                resultList.add(entry.getKey());
            }
        }

        int[] result = new int[resultList.size()];
        for (int i = 0; i < resultList.size(); i++) {
            result[i] = resultList.get(i);
        }

        return result;
    }

    private int dfs(TreeNode node) {
        if (node == null) {
            return 0;
        }

        int leftSum = dfs(node.left);
        int rightSum = dfs(node.right);

        int currentSum = node.val + leftSum + rightSum;

        sumCounts.put(currentSum, sumCounts.getOrDefault(currentSum, 0) + 1);
        maxFreq = Math.max(maxFreq, sumCounts.get(currentSum));

        return currentSum;
    }
}