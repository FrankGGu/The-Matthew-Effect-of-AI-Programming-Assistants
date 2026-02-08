class Solution {
    public int maximizeTheTop(int[] nums, int k) {
        int n = nums.length;
        if (k == 0) return n > 0 ? nums[0] : 0;
        int max = 0;
        for (int i = 0; i < Math.min(k, n); i++) {
            max = Math.max(max, nums[i]);
        }
        if (k < n) {
            max = Math.max(max, nums[k]);
        }
        return max;
    }
}