class Solution {
    public int maximumUniqueSubarray(int[] nums) {
        int maxSum = 0;
        int currentSum = 0;
        int left = 0;
        Set<Integer> set = new HashSet<>();

        for (int right = 0; right < nums.length; right++) {
            while (set.contains(nums[right])) {
                set.remove(nums[left]);
                currentSum -= nums[left];
                left++;
            }
            set.add(nums[right]);
            currentSum += nums[right];
            maxSum = Math.max(maxSum, currentSum);
        }

        return maxSum;
    }
}