class Solution {
    public int rob(TreeNode root) {
        int[] result = robSub(root);
        return Math.max(result[0], result[1]);
    }

    private int[] robSub(TreeNode node) {
        if (node == null) {
            return new int[]{0, 0};
        }

        int[] left = robSub(node.left);
        int[] right = robSub(node.right);

        int robCurrent = node.val + left[1] + right[1];
        int notRobCurrent = Math.max(left[0], left[1]) + Math.max(right[0], right[1]);

        return new int[]{robCurrent, notRobCurrent};
    }
}