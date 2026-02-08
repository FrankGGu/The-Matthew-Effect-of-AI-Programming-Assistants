import java.util.*;

public class Solution {
    private Map<Integer, Integer> sumCount = new HashMap<>();
    private int maxCount = 0;

    public int[] findFrequentTreeSum(TreeNode root) {
        if (root == null) return new int[0];
        calculateSum(root);
        List<Integer> result = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : sumCount.entrySet()) {
            if (entry.getValue() == maxCount) {
                result.add(entry.getKey());
            }
        }
        return result.stream().mapToInt(i -> i).toArray();
    }

    private int calculateSum(TreeNode node) {
        if (node == null) return 0;
        int sum = node.val + calculateSum(node.left) + calculateSum(node.right);
        sumCount.put(sum, sumCount.getOrDefault(sum, 0) + 1);
        maxCount = Math.max(maxCount, sumCount.get(sum));
        return sum;
    }
}