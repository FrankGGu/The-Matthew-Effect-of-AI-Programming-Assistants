public class Solution {

import java.util.*;

public class Solution {
    public int minLevels(TreeNode root) {
        int[] total = new int[1];
        dfs(root, total);
        int[] res = new int[1];
        dfs2(root, 0, total[0], res);
        return res[0];
    }

    private void dfs(TreeNode node, int[] total) {
        if (node == null) return;
        total[0] += node.val;
        dfs(node.left, total);
        dfs(node.right, total);
    }

    private void dfs2(TreeNode node, int level, int total, int[] res) {
        if (node == null) return;
        int leftSum = 0, rightSum = 0;
        dfsSum(node.left, leftSum);
        dfsSum(node.right, rightSum);
        int currentSum = leftSum + rightSum + node.val;
        if (currentSum > total - currentSum) {
            res[0] = Math.min(res[0], level + 1);
        }
        dfs2(node.left, level + 1, total, res);
        dfs2(node.right, level + 1, total, res);
    }

    private void dfsSum(TreeNode node, int sum) {
        if (node == null) return;
        sum += node.val;
        dfsSum(node.left, sum);
        dfsSum(node.right, sum);
    }
}
}