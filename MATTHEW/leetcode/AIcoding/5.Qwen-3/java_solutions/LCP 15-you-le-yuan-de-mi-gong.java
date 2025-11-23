public class Solution {

import java.util.*;

public class Solution {
    public int[] findSafeWalk(TreeNode root, int target) {
        List<Integer> path = new ArrayList<>();
        boolean found = dfs(root, target, path);
        if (!found) {
            return new int[0];
        }
        int[] result = new int[path.size()];
        for (int i = 0; i < result.length; i++) {
            result[i] = path.get(i);
        }
        return result;
    }

    private boolean dfs(TreeNode node, int target, List<Integer> path) {
        if (node == null) {
            return false;
        }
        path.add(node.val);
        if (node.val == target) {
            return true;
        }
        if (dfs(node.left, target, path)) {
            return true;
        }
        if (dfs(node.right, target, path)) {
            return true;
        }
        path.remove(path.size() - 1);
        return false;
    }

    static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode() {}

        TreeNode(int val) {
            this.val = val;
        }

        TreeNode(int val, TreeNode left, TreeNode right) {
            this.val = val;
            this.left = left;
            this.right = right;
        }
    }
}
}