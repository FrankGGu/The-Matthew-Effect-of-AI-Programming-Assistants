public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int countPaths(TreeNode root, int target) {
        Map<Integer, Integer> prefix = new HashMap<>();
        prefix.put(0, 1);
        return dfs(root, target, 0, prefix);
    }

    private int dfs(TreeNode node, int target, int curr, Map<Integer, Integer> prefix) {
        if (node == null) {
            return 0;
        }
        curr ^= node.val;
        int count = prefix.getOrDefault(curr ^ target, 0);
        prefix.put(curr, prefix.getOrDefault(curr, 0) + 1);
        count += dfs(node.left, target, curr, prefix);
        count += dfs(node.right, target, curr, prefix);
        prefix.put(curr, prefix.get(curr) - 1);
        return count;
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