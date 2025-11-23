import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public int widthOfBinaryTree(TreeNode root) {
        if (root == null) return 0;

        Queue<Pair> queue = new LinkedList<>();
        queue.offer(new Pair(root, 0));
        int maxWidth = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            int minIndex = queue.peek().index;
            int first = 0, last = 0;

            for (int i = 0; i < size; i++) {
                Pair current = queue.poll();
                TreeNode node = current.node;
                long currentIndex = current.index - minIndex;

                if (i == 0) first = (int)currentIndex;
                if (i == size - 1) last = (int)currentIndex;

                if (node.left != null) {
                    queue.offer(new Pair(node.left, currentIndex * 2 + 1));
                }
                if (node.right != null) {
                    queue.offer(new Pair(node.right, currentIndex * 2 + 2));
                }
            }
            maxWidth = Math.max(maxWidth, last - first + 1);
        }

        return maxWidth;
    }

    private static class Pair {
        TreeNode node;
        long index;

        public Pair(TreeNode node, long index) {
            this.node = node;
            this.index = index;
        }
    }
}