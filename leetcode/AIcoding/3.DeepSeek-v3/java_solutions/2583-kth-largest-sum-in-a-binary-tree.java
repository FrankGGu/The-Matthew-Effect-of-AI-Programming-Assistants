import java.util.*;

class TreeNode {
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

class Solution {
    public long kthLargestLevelSum(TreeNode root, int k) {
        if (root == null) return -1;

        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        PriorityQueue<Long> minHeap = new PriorityQueue<>();

        while (!queue.isEmpty()) {
            int size = queue.size();
            long levelSum = 0;
            for (int i = 0; i < size; i++) {
                TreeNode node = queue.poll();
                levelSum += node.val;
                if (node.left != null) queue.offer(node.left);
                if (node.right != null) queue.offer(node.right);
            }
            minHeap.offer(levelSum);
            if (minHeap.size() > k) {
                minHeap.poll();
            }
        }

        return minHeap.size() >= k ? minHeap.peek() : -1;
    }
}