class Solution {
    private long min1;
    private long min2 = Long.MAX_VALUE;

    public int findSecondMinimumValue(TreeNode root) {
        if (root == null) {
            return -1;
        }
        min1 = root.val;
        dfs(root);
        return (min2 == Long.MAX_VALUE) ? -1 : (int) min2;
    }

    private void dfs(TreeNode node) {
        if (node == null) {
            return;
        }

        // Pruning condition: If current node's value is already greater than or equal to the
        // current second minimum, we can stop exploring this branch.
        // This is because all values in its subtree will be >= node.val (due to tree property).
        if (min2 != Long.MAX_VALUE && node.val >= min2) {
            return;
        }

        // If node.val is greater than the absolute minimum (min1), it's a candidate for min2.
        if (node.val > min1) {
            min2 = node.val;
        }

        // Recursively explore children.
        // We must explore children even if node.val == min1, because children might have
        // values greater than min1 (and potentially candidates for min2).
        dfs(node.left);
        dfs(node.right);
    }
}