import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public TreeNode addOneRow(TreeNode root, int val, int depth) {
        if (depth == 1) {
            TreeNode newRoot = new TreeNode(val);
            newRoot.left = root;
            return newRoot;
        }

        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        int currentDepth = 1;

        while (!queue.isEmpty() && currentDepth < depth - 1) {
            int levelSize = queue.size();
            for (int i = 0; i < levelSize; i++) {
                TreeNode node = queue.poll();
                if (node.left != null) {
                    queue.offer(node.left);
                }
                if (node.right != null) {
                    queue.offer(node.right);
                }
            }
            currentDepth++;
        }

        // At this point, currentDepth is depth - 1, and queue contains all nodes at this level.
        while (!queue.isEmpty()) {
            TreeNode node = queue.poll();

            TreeNode oldLeft = node.left;
            TreeNode oldRight = node.right;

            node.left = new TreeNode(val);
            node.right = new TreeNode(val);

            node.left.left = oldLeft;
            node.right.right = oldRight;
        }

        return root;
    }
}