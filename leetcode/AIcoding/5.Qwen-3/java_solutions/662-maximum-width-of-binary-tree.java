public class Solution {

import java.util.*;

public class Solution {
    public int widthOfBinaryTree(TreeNode root) {
        if (root == null) return 0;
        Queue<Pair<TreeNode, Integer>> queue = new LinkedList<>();
        queue.offer(new Pair<>(root, 0));
        int maxWidth = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            int left = 0, right = 0;
            for (int i = 0; i < size; i++) {
                Pair<TreeNode, Integer> pair = queue.poll();
                TreeNode node = pair.getKey();
                int index = pair.getValue();
                if (i == 0) left = index;
                if (i == size - 1) right = index;
                if (node.left != null) {
                    queue.offer(new Pair<>(node.left, index * 2));
                }
                if (node.right != null) {
                    queue.offer(new Pair<>(node.right, index * 2 + 1));
                }
            }
            maxWidth = Math.max(maxWidth, right - left + 1);
        }
        return maxWidth;
    }

    static class Pair<K, V> {
        private K key;
        private V value;

        public Pair(K key, V value) {
            this.key = key;
            this.value = value;
        }

        public K getKey() {
            return key;
        }

        public V getValue() {
            return value;
        }
    }
}
}