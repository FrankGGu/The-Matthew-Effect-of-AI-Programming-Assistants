class Solution {
    public long findTheArrayConcVal(int[] nums) {
        long ans = 0;
        int l = 0, r = nums.length - 1;
        while (l < r) {
            String s = String.valueOf(nums[l]) + String.valueOf(nums[r]);
            ans += Long.parseLong(s);
            l++;
            r--;
        }
        if (l == r) {
            ans += nums[l];
        }
        return ans;
    }
}