class Solution {
    public TreeNode constructMaximumBinaryTree(int[] nums) {
        if (nums == null || nums.length == 0) {
            return null;
        }
        return build(nums, 0, nums.length - 1);
    }

    private TreeNode build(int[] nums, int start, int end) {
        if (start > end) {
            return null;
        }

        int maxVal = -1;
        int maxIdx = -1;

        for (int i = start; i <= end; i++) {
            if (nums[i] > maxVal) {
                maxVal = nums[i];
                maxIdx = i;
            }
        }

        TreeNode root = new TreeNode(maxVal);
        root.left = build(nums, start, maxIdx - 1);
        root.right = build(nums, maxIdx + 1, end);

        return root;
    }
}