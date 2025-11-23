class Solution {
    public long countNonDecreasingSubarrays(int[] nums, int k) {
        int n = nums.length;
        long ans = 0;
        int left = 0;
        int count = 0;
        for (int right = 0; right < n; right++) {
            if (right > 0 && nums[right] < nums[right - 1]) {
                count++;
            }
            while (count > k) {
                if (left > 0 && nums[left] < nums[left - 1]) {
                    count--;
                }
                left++;
            }
            ans += (right - left + 1);
        }
        return ans;
    }
}