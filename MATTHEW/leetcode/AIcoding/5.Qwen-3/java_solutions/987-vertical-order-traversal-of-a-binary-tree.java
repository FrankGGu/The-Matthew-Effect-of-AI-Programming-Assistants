public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> verticalOrder(TreeNode root) {
        if (root == null) {
            return new ArrayList<>();
        }

        Map<Integer, List<Integer>> columnMap = new HashMap<>();
        Queue<TreeNode> nodeQueue = new LinkedList<>();
        Queue<Integer> colQueue = new LinkedList<>();

        nodeQueue.add(root);
        colQueue.add(0);

        int minCol = 0;
        int maxCol = 0;

        while (!nodeQueue.isEmpty()) {
            TreeNode node = nodeQueue.poll();
            int col = colQueue.poll();

            if (!columnMap.containsKey(col)) {
                columnMap.put(col, new ArrayList<>());
            }
            columnMap.get(col).add(node.val);

            if (node.left != null) {
                nodeQueue.add(node.left);
                colQueue.add(col - 1);
                minCol = Math.min(minCol, col - 1);
            }

            if (node.right != null) {
                nodeQueue.add(node.right);
                colQueue.add(col + 1);
                maxCol = Math.max(maxCol, col + 1);
            }
        }

        List<List<Integer>> result = new ArrayList<>();
        for (int i = minCol; i <= maxCol; i++) {
            result.add(columnMap.get(i));
        }

        return result;
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