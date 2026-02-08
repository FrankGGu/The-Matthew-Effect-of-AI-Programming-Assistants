class Solution {
    int maxSum = 0;

    public int maxSumBST(TreeNode root) {
        traverse(root);
        return maxSum;
    }

    private int[] traverse(TreeNode root) {
        if (root == null) {
            return new int[]{1, Integer.MAX_VALUE, Integer.MIN_VALUE, 0};
        }

        int[] left = traverse(root.left);
        int[] right = traverse(root.right);

        if (left[0] == 1 && right[0] == 1 && root.val > left[2] && root.val < right[1]) {
            int sum = left[3] + right[3] + root.val;
            maxSum = Math.max(maxSum, sum);
            return new int[]{1, Math.min(root.val, left[1]), Math.max(root.val, right[2]), sum};
        } else {
            return new int[]{0, 0, 0, 0};
        }
    }
}