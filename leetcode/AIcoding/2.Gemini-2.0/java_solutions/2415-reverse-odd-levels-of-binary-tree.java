import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

class Solution {
    public TreeNode reverseOddLevels(TreeNode root) {
        if (root == null) {
            return null;
        }

        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        int level = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            List<TreeNode> levelNodes = new ArrayList<>();

            for (int i = 0; i < size; i++) {
                TreeNode node = queue.poll();
                levelNodes.add(node);

                if (node.left != null) {
                    queue.offer(node.left);
                }
                if (node.right != null) {
                    queue.offer(node.right);
                }
            }

            if (level % 2 != 0) {
                List<Integer> values = new ArrayList<>();
                for(TreeNode node : levelNodes) {
                    values.add(node.val);
                }
                Collections.reverse(values);

                for (int i = 0; i < levelNodes.size(); i++) {
                    levelNodes.get(i).val = values.get(i);
                }
            }

            level++;
        }

        return root;
    }
}