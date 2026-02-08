class Solution {
    public int minSizeSubarray(int[] nums, int target) {
        int n = nums.length;
        long sum = 0;
        for (int num : nums) {
            sum += num;
        }

        long count = target / sum;
        target %= sum;

        int ans = Integer.MAX_VALUE;
        int left = 0;
        long currentSum = 0;

        for (int right = 0; right < 2 * n; right++) {
            currentSum += nums[right % n];
            while (currentSum > target) {
                ans = Math.min(ans, right - left + 1);
                currentSum -= nums[left % n];
                left++;
            }
        }

        return ans == Integer.MAX_VALUE ? -1 : (int) (ans + count * n);
    }
}