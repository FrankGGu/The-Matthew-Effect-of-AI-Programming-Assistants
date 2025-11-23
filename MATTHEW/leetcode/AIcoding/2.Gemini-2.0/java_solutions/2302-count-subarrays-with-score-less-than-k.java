class Solution {
    public long countSubarrays(int[] nums, long k) {
        long count = 0;
        long currentSum = 0;
        int left = 0;
        for (int right = 0; right < nums.length; right++) {
            currentSum += nums[right];
            while (currentSum * (right - left + 1) >= k && left <= right) {
                currentSum -= nums[left];
                left++;
            }
            count += (right - left + 1);
        }
        return count;
    }
}