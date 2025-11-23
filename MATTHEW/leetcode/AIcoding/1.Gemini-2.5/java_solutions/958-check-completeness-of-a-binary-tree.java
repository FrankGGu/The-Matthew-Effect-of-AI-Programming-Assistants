import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public boolean isCompleteTree(TreeNode root) {
        if (root == null) {
            return true;
        }

        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        boolean foundNull = false;

        while (!queue.isEmpty()) {
            TreeNode current = queue.poll();

            if (current == null) {
                foundNull = true;
            } else {
                if (foundNull) {
                    return false;
                }
                queue.offer(current.left);
                queue.offer(current.right);
            }
        }

        return true;
    }
}