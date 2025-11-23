import java.util.*;

class Solution {
    public TreeNode[] findCousins(TreeNode root, TreeNode target) {
        if (root == null || target == null) return new TreeNode[0];
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        boolean found = false;
        List<TreeNode> cousins = new ArrayList<>();

        while (!queue.isEmpty()) {
            int size = queue.size();
            cousins.clear();

            for (int i = 0; i < size; i++) {
                TreeNode node = queue.poll();
                if (node.left == target || node.right == target) found = true;
                else {
                    if (node.left != null) cousins.add(node.left);
                    if (node.right != null) cousins.add(node.right);
                }
            }

            if (found) break;

            for (TreeNode cousin : cousins) {
                queue.offer(cousin);
            }
        }

        return cousins.toArray(new TreeNode[0]);
    }
}