public class Solution {

import java.util.*;

public class Solution {
    public int countHighestScoreNodes(TreeNode root) {
        Map<Integer, Integer> scoreMap = new HashMap<>();
        int[] maxScore = {Integer.MIN_VALUE};
        int[] count = {0};

        dfs(root, scoreMap, maxScore, count);

        return count[0];
    }

    private int dfs(TreeNode node, Map<Integer, Integer> scoreMap, int[] maxScore, int[] count) {
        if (node == null) {
            return 0;
        }

        int leftSubtreeSize = dfs(node.left, scoreMap, maxScore, count);
        int rightSubtreeSize = dfs(node.right, scoreMap, maxScore, count);

        int totalNodes = leftSubtreeSize + rightSubtreeSize + 1;
        int score = 1;

        if (leftSubtreeSize > 0) {
            score *= leftSubtreeSize;
        }
        if (rightSubtreeSize > 0) {
            score *= rightSubtreeSize;
        }

        scoreMap.put(score, scoreMap.getOrDefault(score, 0) + 1);

        if (score > maxScore[0]) {
            maxScore[0] = score;
            count[0] = 1;
        } else if (score == maxScore[0]) {
            count[0]++;
        }

        return totalNodes;
    }

    public class TreeNode {
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