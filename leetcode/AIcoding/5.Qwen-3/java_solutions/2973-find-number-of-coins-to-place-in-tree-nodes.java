public class Solution {

import java.util.*;

public class Solution {
    public int[] findNumberOfCoins(TreeNode root) {
        int[] result = new int[1];
        dfs(root, result);
        return result;
    }

    private int dfs(TreeNode node, int[] result) {
        if (node == null) {
            return 0;
        }
        int left = dfs(node.left, result);
        int right = dfs(node.right, result);
        int coins = left + right + 1;
        result[0] += coins;
        return coins;
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