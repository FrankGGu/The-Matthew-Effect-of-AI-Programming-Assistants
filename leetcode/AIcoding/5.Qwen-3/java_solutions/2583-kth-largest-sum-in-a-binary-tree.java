public class Solution {

import java.util.*;

public class Solution {
    public int kthLargestSum(TreeNode root, int k) {
        if (root == null) return 0;

        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);

        List<Integer> levelSums = new ArrayList<>();

        while (!queue.isEmpty()) {
            int levelSize = queue.size();
            int levelSum = 0;

            for (int i = 0; i < levelSize; i++) {
                TreeNode node = queue.poll();
                levelSum += node.val;

                if (node.left != null) {
                    queue.offer(node.left);
                }
                if (node.right != null) {
                    queue.offer(node.right);
                }
            }

            levelSums.add(levelSum);
        }

        Collections.sort(levelSums, Collections.reverseOrder());

        return levelSums.get(k - 1);
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