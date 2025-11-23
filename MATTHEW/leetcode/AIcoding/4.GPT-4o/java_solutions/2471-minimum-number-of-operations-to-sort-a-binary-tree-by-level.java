import java.util.*;

public class Solution {
    public int minimumOperations(TreeNode root) {
        if (root == null) return 0;

        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        int operations = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            List<Integer> level = new ArrayList<>();
            for (int i = 0; i < size; i++) {
                TreeNode node = queue.poll();
                level.add(node.val);
                if (node.left != null) queue.offer(node.left);
                if (node.right != null) queue.offer(node.right);
            }
            operations += countOperations(level);
        }

        return operations;
    }

    private int countOperations(List<Integer> level) {
        List<Integer> sorted = new ArrayList<>(level);
        Collections.sort(sorted);
        int count = 0;
        Map<Integer, Integer> indexMap = new HashMap<>();

        for (int i = 0; i < level.size(); i++) {
            indexMap.put(level.get(i), i);
        }

        for (int i = 0; i < level.size(); i++) {
            if (level.get(i).equals(sorted.get(i))) {
                continue;
            } else {
                count++;
                int originalIndex = indexMap.get(sorted.get(i));
                Collections.swap(level, i, originalIndex);
                indexMap.put(level.get(originalIndex), originalIndex);
                indexMap.put(level.get(i), i);
            }
        }

        return count;
    }
}