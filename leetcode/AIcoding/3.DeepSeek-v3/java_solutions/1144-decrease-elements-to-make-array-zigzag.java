class Solution {
    public int movesToMakeZigzag(int[] nums) {
        int[] res = new int[2];
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            int left = i > 0 ? nums[i - 1] : Integer.MAX_VALUE;
            int right = i < n - 1 ? nums[i + 1] : Integer.MAX_VALUE;
            res[i % 2] += Math.max(0, nums[i] - Math.min(left, right) + 1);
        }
        return Math.min(res[0], res[1]);
    }
}