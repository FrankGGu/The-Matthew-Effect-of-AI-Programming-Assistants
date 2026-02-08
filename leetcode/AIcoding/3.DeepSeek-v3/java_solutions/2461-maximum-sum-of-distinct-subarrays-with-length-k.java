class Solution {
    public long maximumSubarraySum(int[] nums, int k) {
        long maxSum = 0;
        long currentSum = 0;
        Map<Integer, Integer> freq = new HashMap<>();
        int left = 0;

        for (int right = 0; right < nums.length; right++) {
            currentSum += nums[right];
            freq.put(nums[right], freq.getOrDefault(nums[right], 0) + 1);

            if (right - left + 1 == k) {
                if (freq.size() == k) {
                    maxSum = Math.max(maxSum, currentSum);
                }
                currentSum -= nums[left];
                freq.put(nums[left], freq.get(nums[left]) - 1);
                if (freq.get(nums[left]) == 0) {
                    freq.remove(nums[left]);
                }
                left++;
            }
        }

        return maxSum;
    }
}