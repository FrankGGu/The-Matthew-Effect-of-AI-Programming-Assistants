class Solution {
    public int purchasePlans(int[] nums, int target) {
        Arrays.sort(nums);
        int left = 0, right = nums.length - 1;
        int res = 0;
        int mod = 1000000007;
        while (left < right) {
            if (nums[left] + nums[right] > target) {
                right--;
            } else {
                res += right - left;
                res %= mod;
                left++;
            }
        }
        return res % mod;
    }
}