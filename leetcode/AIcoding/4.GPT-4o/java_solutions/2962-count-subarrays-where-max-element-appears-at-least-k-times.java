public class Solution {
    public long countSubarrays(int[] nums, int k) {
        long result = 0;
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            int count = 0;
            for (int j = i; j < n; j++) {
                count += nums[j] == nums[i] ? 1 : 0;
                if (count >= k) {
                    result++;
                }
            }
        }
        return result;
    }
}