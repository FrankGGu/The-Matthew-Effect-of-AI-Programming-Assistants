import java.util.LinkedList;
import java.util.Queue;
import java.util.AbstractMap;

class Solution {
    public int widthOfBinaryTree(TreeNode root) {
        if (root == null) {
            return 0;
        }

        long maxWidth = 0;
        Queue<AbstractMap.SimpleEntry<TreeNode, Long>> queue = new LinkedList<>();
        queue.offer(new AbstractMap.SimpleEntry<>(root, 0L));

        while (!queue.isEmpty()) {
            int levelSize = queue.size();
            long firstIndex = queue.peek().getValue();
            long lastIndex = firstIndex; 

            for (int i = 0; i < levelSize; i++) {
                AbstractMap.SimpleEntry<TreeNode, Long> entry = queue.poll();
                TreeNode currentNode = entry.getKey();
                long currentIndex = entry.getValue();

                lastIndex = currentIndex;

                if (currentNode.left != null) {
                    queue.offer(new AbstractMap.SimpleEntry<>(currentNode.left, 2 * (currentIndex - firstIndex)));
                }
                if (currentNode.right != null) {
                    queue.offer(new AbstractMap.SimpleEntry<>(currentNode.right, 2 * (currentIndex - firstIndex) + 1));
                }
            }
            maxWidth = Math.max(maxWidth, lastIndex - firstIndex + 1);
        }

        return (int) maxWidth;
    }
}