class Solution {
    public long maximumSubarraySum(int[] nums, int k) {
        Map<Integer, Long> map = new HashMap<>();
        long maxSum = Long.MIN_VALUE;
        long prefixSum = 0;
        map.put(0, -1L);

        for (int i = 0; i < nums.length; i++) {
            prefixSum += nums[i];
            if (map.containsKey(nums[i] - k)) {
                long prevIndex = map.get(nums[i] - k);
                long currentSum = prefixSum - (prevIndex == -1 ? 0 : getPrefixSum(nums, (int) prevIndex));
                if (currentSum > maxSum) {
                    maxSum = currentSum;
                }
            }
            if (map.containsKey(nums[i] + k)) {
                long prevIndex = map.get(nums[i] + k);
                long currentSum = prefixSum - (prevIndex == -1 ? 0 : getPrefixSum(nums, (int) prevIndex));
                if (currentSum > maxSum) {
                    maxSum = currentSum;
                }
            }
            if (!map.containsKey(nums[i]) || prefixSum < getPrefixSum(nums, map.get(nums[i]))) {
                map.put(nums[i], (long) i);
            }
        }
        return maxSum == Long.MIN_VALUE ? 0 : maxSum;
    }

    private long getPrefixSum(int[] nums, int index) {
        long sum = 0;
        for (int i = 0; i <= index; i++) {
            sum += nums[i];
        }
        return sum;
    }
}