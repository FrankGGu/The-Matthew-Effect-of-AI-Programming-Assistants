import java.util.LinkedList;
import java.util.Queue;

public class Solution {
    public int widthOfBinaryTree(TreeNode root) {
        if (root == null) return 0;
        int maxWidth = 0;
        Queue<Pair<TreeNode, Integer>> queue = new LinkedList<>();
        queue.offer(new Pair<>(root, 0));

        while (!queue.isEmpty()) {
            int size = queue.size();
            int leftmost = queue.peek().getValue();
            int rightmost = leftmost;
            for (int i = 0; i < size; i++) {
                Pair<TreeNode, Integer> pair = queue.poll();
                TreeNode node = pair.getKey();
                rightmost = pair.getValue();
                if (node.left != null) {
                    queue.offer(new Pair<>(node.left, 2 * rightmost));
                }
                if (node.right != null) {
                    queue.offer(new Pair<>(node.right, 2 * rightmost + 1));
                }
            }
            maxWidth = Math.max(maxWidth, rightmost - leftmost + 1);
        }

        return maxWidth;
    }
}