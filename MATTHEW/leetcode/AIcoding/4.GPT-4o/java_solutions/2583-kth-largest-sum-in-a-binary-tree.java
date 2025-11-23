import java.util.*;

public class Solution {
    public int kthLargestLevelSum(TreeNode root, int k) {
        if (root == null) return 0;
        List<Long> levelSums = new ArrayList<>();
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);

        while (!queue.isEmpty()) {
            int size = queue.size();
            long sum = 0;
            for (int i = 0; i < size; i++) {
                TreeNode node = queue.poll();
                sum += node.val;
                if (node.left != null) queue.offer(node.left);
                if (node.right != null) queue.offer(node.right);
            }
            levelSums.add(sum);
        }

        Collections.sort(levelSums, Collections.reverseOrder());
        return k <= levelSums.size() ? (int)(long)levelSums.get(k - 1) : -1;
    }
}