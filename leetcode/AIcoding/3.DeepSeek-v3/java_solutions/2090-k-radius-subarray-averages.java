class Solution {
    public int[] getAverages(int[] nums, int k) {
        int n = nums.length;
        int[] result = new int[n];
        Arrays.fill(result, -1);
        if (2 * k + 1 > n) {
            return result;
        }
        long sum = 0;
        for (int i = 0; i < 2 * k + 1; i++) {
            sum += nums[i];
        }
        result[k] = (int) (sum / (2 * k + 1));
        for (int i = k + 1; i < n - k; i++) {
            sum += nums[i + k] - nums[i - k - 1];
            result[i] = (int) (sum / (2 * k + 1));
        }
        return result;
    }
}