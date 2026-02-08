class Solution {
    public int countSubarrays(int[] nums, int k) {
        int count = 0, sum = 0, n = nums.length;
        for (int i = 0, j = 0; j < n; j++) {
            sum += nums[j];
            while (sum > k) {
                sum -= nums[i++];
            }
            count += j - i + 1;
        }
        return count;
    }
}