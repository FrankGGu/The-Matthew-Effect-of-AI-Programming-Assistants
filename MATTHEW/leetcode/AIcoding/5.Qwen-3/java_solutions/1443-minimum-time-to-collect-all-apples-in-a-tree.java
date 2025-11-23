public class Solution {

import java.util.*;

public class Solution {
    public int minTimeToCollectAllApples(TreeNode root) {
        Set<Integer> apples = new HashSet<>();
        dfs(root, null, apples);
        return dfsTime(root, null, apples);
    }

    private boolean dfs(TreeNode node, TreeNode parent, Set<Integer> apples) {
        if (node == null) return false;
        boolean hasApple = node.val > 0;
        if (node.left != null) hasApple |= dfs(node.left, node, apples);
        if (node.right != null) hasApple |= dfs(node.right, node, apples);
        if (hasApple) apples.add(node.val);
        return hasApple;
    }

    private int dfsTime(TreeNode node, TreeNode parent, Set<Integer> apples) {
        if (node == null) return 0;
        int time = 0;
        if (node.left != null && apples.contains(node.left.val)) {
            time += 2 + dfsTime(node.left, node, apples);
        }
        if (node.right != null && apples.contains(node.right.val)) {
            time += 2 + dfsTime(node.right, node, apples);
        }
        return time;
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