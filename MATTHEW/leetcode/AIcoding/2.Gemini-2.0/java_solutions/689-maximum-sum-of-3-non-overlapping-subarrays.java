class Solution {
    public int[] maxSumOfThreeSubarrays(int[] nums, int k) {
        int n = nums.length;
        int[] sum = new int[n - k + 1];
        int currSum = 0;
        for (int i = 0; i < k; i++) {
            currSum += nums[i];
        }
        sum[0] = currSum;
        for (int i = k; i < n; i++) {
            currSum += nums[i] - nums[i - k];
            sum[i - k + 1] = currSum;
        }

        int[] left = new int[n - k + 1];
        int best = 0;
        for (int i = 0; i < n - k + 1; i++) {
            if (sum[i] > sum[best]) {
                best = i;
            }
            left[i] = best;
        }

        int[] right = new int[n - k + 1];
        best = n - k;
        for (int i = n - k; i >= 0; i--) {
            if (sum[i] >= sum[best]) {
                best = i;
            }
            right[i] = best;
        }

        int a = 0, b = 0, c = 0;
        for (int j = k; j < n - 2 * k + 1; j++) {
            int i = left[j - k];
            int l = right[j + k];
            if (sum[i] + sum[j] + sum[l] > sum[a] + sum[b] + sum[c]) {
                a = i;
                b = j;
                c = l;
            }
        }
        return new int[]{a, b, c};
    }
}