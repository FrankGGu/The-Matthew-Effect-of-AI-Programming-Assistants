class Solution {
    public int countKSubarrays(int[] nums, int k) {
        int count = 0, n = nums.length;
        for (int i = 0; i < n; i++) {
            long powerSum = 0;
            for (int j = i; j < n; j++) {
                powerSum += nums[j];
                if (powerSum == k) {
                    count++;
                }
            }
        }
        return count;
    }
}