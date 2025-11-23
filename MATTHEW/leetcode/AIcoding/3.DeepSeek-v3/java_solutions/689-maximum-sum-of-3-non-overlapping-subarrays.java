class Solution {
    public int[] maxSumOfThreeSubarrays(int[] nums, int k) {
        int n = nums.length;
        int[] sum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            sum[i + 1] = sum[i] + nums[i];
        }

        int[] left = new int[n];
        int max = 0;
        for (int i = k - 1; i < n; i++) {
            int current = sum[i + 1] - sum[i + 1 - k];
            if (current > max) {
                max = current;
                left[i] = i - k + 1;
            } else {
                left[i] = left[i - 1];
            }
        }

        int[] right = new int[n];
        max = 0;
        for (int i = n - k; i >= 0; i--) {
            int current = sum[i + k] - sum[i];
            if (current >= max) {
                max = current;
                right[i] = i;
            } else {
                right[i] = right[i + 1];
            }
        }

        int[] res = new int[3];
        max = 0;
        for (int i = k; i <= n - 2 * k; i++) {
            int l = left[i - 1];
            int r = right[i + k];
            int total = (sum[l + k] - sum[l]) + (sum[i + k] - sum[i]) + (sum[r + k] - sum[r]);
            if (total > max) {
                max = total;
                res[0] = l;
                res[1] = i;
                res[2] = r;
            }
        }
        return res;
    }
}