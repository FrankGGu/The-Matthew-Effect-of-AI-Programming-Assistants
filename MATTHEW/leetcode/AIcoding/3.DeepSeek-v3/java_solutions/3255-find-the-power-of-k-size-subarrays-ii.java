class Solution {
    public long[] powerOfSubarrays(int[] nums, int k) {
        int n = nums.length;
        long[] result = new long[n - k + 1];
        long currentPower = 1;

        for (int i = 0; i < k; i++) {
            currentPower *= nums[i];
        }
        result[0] = currentPower;

        for (int i = 1; i <= n - k; i++) {
            currentPower = (currentPower / nums[i - 1]) * nums[i + k - 1];
            result[i] = currentPower;
        }

        return result;
    }
}