class Solution {
    public TreeNode sortedArrayToBST(int[] nums) {
        if (nums == null || nums.length == 0) {
            return null;
        }
        return convertToBST(nums, 0, nums.length - 1);
    }

    private TreeNode convertToBST(int[] nums, int start, int end) {
        if (start > end) {
            return null;
        }

        int mid = start + (end - start) / 2;
        TreeNode root = new TreeNode(nums[mid]);

        root.left = convertToBST(nums, start, mid - 1);
        root.right = convertToBST(nums, mid + 1, end);

        return root;
    }
}