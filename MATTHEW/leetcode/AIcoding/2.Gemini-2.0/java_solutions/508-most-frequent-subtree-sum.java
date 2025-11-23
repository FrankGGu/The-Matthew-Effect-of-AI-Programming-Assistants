import java.util.*;

class Solution {
    private Map<Integer, Integer> sumFrequency = new HashMap<>();
    private int maxFrequency = 0;

    public int[] findFrequentTreeSum(TreeNode root) {
        calculateSubtreeSum(root);

        List<Integer> result = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : sumFrequency.entrySet()) {
            if (entry.getValue() == maxFrequency) {
                result.add(entry.getKey());
            }
        }

        int[] resultArray = new int[result.size()];
        for (int i = 0; i < result.size(); i++) {
            resultArray[i] = result.get(i);
        }

        return resultArray;
    }

    private int calculateSubtreeSum(TreeNode node) {
        if (node == null) {
            return 0;
        }

        int leftSum = calculateSubtreeSum(node.left);
        int rightSum = calculateSubtreeSum(node.right);

        int subtreeSum = node.val + leftSum + rightSum;

        sumFrequency.put(subtreeSum, sumFrequency.getOrDefault(subtreeSum, 0) + 1);
        maxFrequency = Math.max(maxFrequency, sumFrequency.get(subtreeSum));

        return subtreeSum;
    }
}