class Solution {
    public int numSubarraysWithSum(int[] nums, int goal) {
        int n = nums.length;
        int[] freq = new int[n + 1];
        freq[0] = 1;

        int count = 0;
        int currentSum = 0;

        for (int num : nums) {
            currentSum += num;
            int target = currentSum - goal;

            if (target >= 0 && target <= n) {
                count += freq[target];
            }

            freq[currentSum]++;
        }

        return count;
    }
}