class Solution {
    public long[] findPrefixScore(int[] nums) {
        int n = nums.length;
        long[] res = new long[n];
        int max = nums[0];
        res[0] = nums[0] + max;
        for (int i = 1; i < n; i++) {
            max = Math.max(max, nums[i]);
            res[i] = res[i - 1] + nums[i] + max;
        }
        return res;
    }
}