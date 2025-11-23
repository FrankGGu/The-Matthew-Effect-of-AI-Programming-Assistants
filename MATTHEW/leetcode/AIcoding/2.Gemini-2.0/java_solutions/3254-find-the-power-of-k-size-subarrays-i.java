class Solution {
    public int findTheOriginalArray(int[] nums, int k) {
        int n = nums.length;
        int count = 0;
        for (int i = 0; i < n; i++) {
            int sum = 0;
            for (int j = i; j < Math.min(i + k, n); j++) {
                sum += nums[j];
            }
            if (Math.min(i + k, n) - i == k && sum % 2 != 0) {
                count++;
            }
        }
        return count;
    }
}