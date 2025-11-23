public class Solution {

import java.util.*;

public class Solution {
    public int minimumOperations(TreeNode root) {
        List<List<Integer>> levels = new ArrayList<>();
        Queue<TreeNode> queue = new LinkedList<>();
        queue.add(root);

        while (!queue.isEmpty()) {
            int size = queue.size();
            List<Integer> level = new ArrayList<>();
            for (int i = 0; i < size; i++) {
                TreeNode node = queue.poll();
                level.add(node.val);
                if (node.left != null) queue.add(node.left);
                if (node.right != null) queue.add(node.right);
            }
            levels.add(level);
        }

        int operations = 0;
        for (List<Integer> level : levels) {
            List<Integer> sorted = new ArrayList<>(level);
            Collections.sort(sorted);
            Map<Integer, Integer> indexMap = new HashMap<>();
            for (int i = 0; i < sorted.size(); i++) {
                indexMap.put(sorted.get(i), i);
            }
            int[] parent = new int[level.size()];
            for (int i = 0; i < level.size(); i++) {
                parent[i] = i;
            }
            for (int i = 0; i < level.size(); i++) {
                int originalIndex = indexMap.get(level.get(i));
                if (originalIndex != i) {
                    int temp = level.get(i);
                    level.set(i, level.get(originalIndex));
                    level.set(originalIndex, temp);
                    operations++;
                }
            }
        }
        return operations;
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