class Solution {
    public int goodNodes(TreeNode root) {
        return goodNodesHelper(root, Integer.MIN_VALUE);
    }

    private int goodNodesHelper(TreeNode root, int maxSoFar) {
        if (root == null) {
            return 0;
        }

        int count = 0;
        if (root.val >= maxSoFar) {
            count++;
        }

        int newMax = Math.max(maxSoFar, root.val);

        count += goodNodesHelper(root.left, newMax);
        count += goodNodesHelper(root.right, newMax);

        return count;
    }
}