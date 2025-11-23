class Solution {
    private int maxLength = 0;

    public int longestUnivaluePath(TreeNode root) {
        longestPath(root);
        return maxLength;
    }

    private int longestPath(TreeNode node) {
        if (node == null) return 0;

        int leftLength = longestPath(node.left);
        int rightLength = longestPath(node.right);

        int left = 0, right = 0;
        if (node.left != null && node.left.val == node.val) {
            left = leftLength + 1;
        }
        if (node.right != null && node.right.val == node.val) {
            right = rightLength + 1;
        }

        maxLength = Math.max(maxLength, left + right);
        return Math.max(left, right);
    }
}