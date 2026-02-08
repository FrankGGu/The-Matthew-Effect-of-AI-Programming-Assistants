class Solution {
    public int maxCoins(int[] nums, int k) {
        Arrays.sort(nums);
        int n = nums.length;
        int left = 0;
        int right = n - 1;
        int res = 0;
        while (left <= right && k > 0) {
            if (nums[right] >= nums[left]) {
                res += nums[right];
                right--;
                k--;
            } else {
                res += nums[left];
                left++;
                k--;
            }
        }
        return res;
    }
}