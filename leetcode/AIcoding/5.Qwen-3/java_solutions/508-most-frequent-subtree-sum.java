public class Solution {

import java.util.*;

public class Solution {
    private int maxCount = 0;
    private Map<Integer, Integer> sumCount = new HashMap<>();

    public int[] findFrequentSubtreeSum(TreeNode root) {
        postOrder(root);
        List<Integer> result = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : sumCount.entrySet()) {
            if (entry.getValue() == maxCount) {
                result.add(entry.getKey());
            }
        }
        int[] array = new int[result.size()];
        for (int i = 0; i < array.length; i++) {
            array[i] = result.get(i);
        }
        return array;
    }

    private int postOrder(TreeNode node) {
        if (node == null) {
            return 0;
        }
        int left = postOrder(node.left);
        int right = postOrder(node.right);
        int sum = left + right + node.val;
        sumCount.put(sum, sumCount.getOrDefault(sum, 0) + 1);
        maxCount = Math.max(maxCount, sumCount.get(sum));
        return sum;
    }
}

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;

    TreeNode(int x) {
        val = x;
    }
}
}