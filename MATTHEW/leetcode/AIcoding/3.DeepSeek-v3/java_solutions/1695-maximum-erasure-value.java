class Solution {
    public int maximumUniqueSubarray(int[] nums) {
        Set<Integer> set = new HashSet<>();
        int maxSum = 0;
        int currentSum = 0;
        int left = 0;

        for (int right = 0; right < nums.length; right++) {
            while (set.contains(nums[right])) {
                currentSum -= nums[left];
                set.remove(nums[left]);
                left++;
            }
            set.add(nums[right]);
            currentSum += nums[right];
            maxSum = Math.max(maxSum, currentSum);
        }

        return maxSum;
    }
}