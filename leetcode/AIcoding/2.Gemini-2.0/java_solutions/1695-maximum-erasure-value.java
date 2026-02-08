class Solution {
    public int maximumUniqueSubarray(int[] nums) {
        int left = 0;
        int right = 0;
        int currentSum = 0;
        int maxSum = 0;
        boolean[] seen = new boolean[10001]; 

        while (right < nums.length) {
            while (seen[nums[right]]) {
                seen[nums[left]] = false;
                currentSum -= nums[left];
                left++;
            }

            seen[nums[right]] = true;
            currentSum += nums[right];
            maxSum = Math.max(maxSum, currentSum);
            right++;
        }

        return maxSum;
    }
}