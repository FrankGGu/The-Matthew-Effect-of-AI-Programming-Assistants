import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

class Solution {
    public List<List<Integer>> zigzagLevelOrder(TreeNode root) {
        List<List<Integer>> result = new ArrayList<>();
        if (root == null) {
            return result;
        }

        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        boolean leftToRight = true;

        while (!queue.isEmpty()) {
            int size = queue.size();
            List<Integer> level = new ArrayList<>();
            for (int i = 0; i < size; i++) {
                TreeNode node = queue.poll();
                level.add(node.val);

                if (node.left != null) {
                    queue.offer(node.left);
                }
                if (node.right != null) {
                    queue.offer(node.right);
                }
            }

            if (!leftToRight) {
                List<Integer> reversedLevel = new ArrayList<>();
                for (int i = level.size() - 1; i >= 0; i--) {
                    reversedLevel.add(level.get(i));
                }
                result.add(reversedLevel);
            } else {
                result.add(level);
            }

            leftToRight = !leftToRight;
        }

        return result;
    }
}