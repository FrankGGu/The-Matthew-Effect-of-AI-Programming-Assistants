class Solution {
    public int rob(TreeNode root) {
        int[] result = robSub(root);
        return Math.max(result[0], result[1]);
    }

    private int[] robSub(TreeNode root) {
        if (root == null) {
            return new int[2];
        }

        int[] left = robSub(root.left);
        int[] right = robSub(root.right);

        int[] result = new int[2];
        result[0] = root.val + left[1] + right[1];
        result[1] = Math.max(left[0], left[1]) + Math.max(right[0], right[1]);

        return result;
    }
}