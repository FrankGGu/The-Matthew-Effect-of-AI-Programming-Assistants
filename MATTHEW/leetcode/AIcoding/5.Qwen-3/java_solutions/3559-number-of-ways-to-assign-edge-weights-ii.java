public class Solution {

import java.util.*;

public class Solution {
    public int numberOfWays(TreeNode root) {
        Map<Integer, Integer> count = new HashMap<>();
        dfs(root, count);
        return count.get(0);
    }

    private int dfs(TreeNode node, Map<Integer, Integer> count) {
        if (node == null) {
            return 0;
        }
        int left = dfs(node.left, count);
        int right = dfs(node.right, count);
        if (left == right) {
            count.put(left + 1, count.getOrDefault(left + 1, 0) + 1);
        } else {
            count.put(0, count.getOrDefault(0, 0) + 1);
        }
        return left + right + 1;
    }

    static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;
        TreeNode() {}
        TreeNode(int val) { this.val = val; }
        TreeNode(int val, TreeNode left, TreeNode right) {
            this.val = val;
            this.left = left;
            this.right = right;
        }
    }
}
}