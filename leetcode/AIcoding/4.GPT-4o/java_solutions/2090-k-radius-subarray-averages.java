class Solution {
    public int[] getAverages(int[] nums, int k) {
        int n = nums.length;
        int[] result = new int[n];
        long sum = 0;

        for (int i = 0; i < n; i++) {
            if (i < 2 * k + 1) {
                sum += nums[i];
                if (i == 2 * k) {
                    result[k] = (int) (sum / (2 * k + 1));
                }
            } else {
                sum += nums[i] - nums[i - (2 * k + 1)];
                result[i - k] = (int) (sum / (2 * k + 1));
            }
        }

        for (int i = 0; i < n; i++) {
            if (result[i] == 0 && (i < k || i >= n - k)) {
                result[i] = -1;
            }
        }

        return result;
    }
}