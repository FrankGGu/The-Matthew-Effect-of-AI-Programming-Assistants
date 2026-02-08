import java.util.LinkedList;
import java.util.List;
import java.util.Queue;
import java.util.ArrayList;

class Solution {
    public TreeNode replaceCousins(TreeNode root) {
        if (root == null) {
            return null;
        }

        // The root node has no cousins, so its value remains 0.
        root.val = 0;

        Queue<TreeNode> queue = new LinkedList<>();
        // Only add root to queue if it has children, as we process children of nodes in the queue.
        // If root has no children, the queue will remain empty and the loop won't run,
        // correctly returning root with val 0.
        if (root.left != null || root.right != null) {
            queue.offer(root);
        }

        while (!queue.isEmpty()) {
            int levelSize = queue.size();
            List<TreeNode> currentLevelParents = new ArrayList<>(); // Stores parents of the *next* level nodes
            List<TreeNode> nextLevelNodes = new ArrayList<>();      // Stores nodes of the *next* level
            int nextLevelSum = 0;

            // First pass: Iterate through all parents in the current level
            // Collect all children (nodes of the next level) and their values
            for (int i = 0; i < levelSize; i++) {
                TreeNode parent = queue.poll();
                currentLevelParents.add(parent);

                if (parent.left != null) {
                    nextLevelNodes.add(parent.left);
                }
                if (parent.right != null) {
                    nextLevelNodes.add(parent.right);
                }
            }

            // Calculate the total sum of values for all nodes in the next level
            for (TreeNode node : nextLevelNodes) {
                nextLevelSum += node.val;
            }

            // Second pass: Iterate through the parents again to update their children's values
            for (TreeNode parent : currentLevelParents) {
                int parentChildrenSum = 0;
                if (parent.left != null) {
                    parentChildrenSum += parent.left.val;
                }
                if (parent.right != null) {
                    parentChildrenSum += parent.right.val;
                }

                // Update children's values and add them to the queue for the next level
                if (parent.left != null) {
                    parent.left.val = nextLevelSum - parentChildrenSum;
                    queue.offer(parent.left);
                }
                if (parent.right != null) {
                    parent.right.val = nextLevelSum - parentChildrenSum;
                    queue.offer(parent.right);
                }
            }
        }

        return root;
    }
}