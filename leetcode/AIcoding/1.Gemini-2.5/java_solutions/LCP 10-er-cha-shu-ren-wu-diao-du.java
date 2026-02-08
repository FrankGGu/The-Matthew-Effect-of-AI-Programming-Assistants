class Solution {
    public long minTime(TreeNode root, int k) {
        return dfs(root, k);
    }

    private long dfs(TreeNode node, int k) {
        if (node == null) {
            return 0;
        }

        long leftSubtreeTime = dfs(node.left, k);
        long rightSubtreeTime = dfs(node.right, k);

        long currentTime = 1; // Time for the current node itself (each task takes 1 unit)

        if (node.left != null && node.right != null) {
            // Both children exist. We must complete the current node, then one child's subtree,
            // then the other child's subtree.
            // A cooldown 'k' applies when switching from one sibling subtree to the other.
            // The total time for this node's subtree will be:
            // 1 (for node) + time for left subtree + k (cooldown) + time for right subtree.
            // The order of processing left/right subtrees does not change this total sum.
            currentTime += leftSubtreeTime + k + rightSubtreeTime;
        } else if (node.left != null) {
            // Only the left child exists. No cooldown is applied as there's no other sibling subtree to switch to.
            currentTime += leftSubtreeTime;
        } else if (node.right != null) {
            // Only the right child exists. No cooldown is applied.
            currentTime += rightSubtreeTime;
        }
        // If both children are null, currentTime remains 1 (only the current node is processed).

        return currentTime;
    }
}