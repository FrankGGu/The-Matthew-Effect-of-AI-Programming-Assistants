public class Solution {

import java.util.*;

public class Solution {
    public int numberOfWays(TreeNode root) {
        Map<Integer, Integer> count = new HashMap<>();
        dfs(root, count);
        return count.get(1);
    }

    private int dfs(TreeNode node, Map<Integer, Integer> count) {
        if (node == null) {
            return 0;
        }
        int left = dfs(node.left, count);
        int right = dfs(node.right, count);
        if (left == 0 && right == 0) {
            count.put(1, count.getOrDefault(1, 0) + 1);
            return 1;
        } else if (left == 0) {
            count.put(right, count.getOrDefault(right, 0) + 1);
            return right;
        } else if (right == 0) {
            count.put(left, count.getOrDefault(left, 0) + 1);
            return left;
        } else {
            int val = left + right;
            count.put(val, count.getOrDefault(val, 0) + 1);
            return val;
        }
    }

    static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode(int x) {
            val = x;
        }
    }
}
}