import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public boolean isCompleteTree(TreeNode root) {
        if (root == null) {
            return true;
        }

        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        boolean flag = false;

        while (!queue.isEmpty()) {
            TreeNode node = queue.poll();

            if (node == null) {
                flag = true;
            } else {
                if (flag) {
                    return false;
                }
                queue.offer(node.left);
                queue.offer(node.right);
            }
        }

        return true;
    }
}