public class Solution {

import java.util.*;

public class Solution {
    public int minCostToMakePathEqual(TreeNode root, int[] target) {
        Map<Integer, Integer> map = new HashMap<>();
        dfs(root, 0, map);
        int res = 0;
        for (int t : target) {
            res += Math.abs(map.get(t) - map.get(0));
        }
        return res;
    }

    private int dfs(TreeNode node, int cost, Map<Integer, Integer> map) {
        if (node == null) return 0;
        if (node.left == null && node.right == null) {
            map.put(cost, map.getOrDefault(cost, 0) + 1);
            return 1;
        }
        int left = dfs(node.left, cost * 2, map);
        int right = dfs(node.right, cost * 2 + 1, map);
        return left + right;
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