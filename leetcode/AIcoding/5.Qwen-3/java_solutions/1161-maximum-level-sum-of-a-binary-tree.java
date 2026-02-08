public class Solution {

import java.util.*;

public class Solution {
    public int maxLevelSum(TreeNode root) {
        if (root == null) return 0;

        Queue<TreeNode> queue = new LinkedList<>();
        queue.add(root);

        int maxSum = Integer.MIN_VALUE;
        int resultLevel = 0;
        int currentLevel = 0;

        while (!queue.isEmpty()) {
            currentLevel++;
            int levelSize = queue.size();
            int levelSum = 0;

            for (int i = 0; i < levelSize; i++) {
                TreeNode node = queue.poll();
                levelSum += node.val;

                if (node.left != null) {
                    queue.add(node.left);
                }
                if (node.right != null) {
                    queue.add(node.right);
                }
            }

            if (levelSum > maxSum) {
                maxSum = levelSum;
                resultLevel = currentLevel;
            }
        }

        return resultLevel;
    }

    public static class TreeNode {
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