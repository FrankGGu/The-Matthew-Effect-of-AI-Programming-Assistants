import java.util.Arrays;

class Solution {
    public long minCost(int[] nums, int[] cost) {
        int n = nums.length;
        int[][] arr = new int[n][2];
        for (int i = 0; i < n; i++) {
            arr[i][0] = nums[i];
            arr[i][1] = cost[i];
        }
        Arrays.sort(arr, (a, b) -> a[0] - b[0]);
        long[] prefixSum = new long[n];
        prefixSum[0] = arr[0][1];
        for (int i = 1; i < n; i++) {
            prefixSum[i] = prefixSum[i - 1] + arr[i][1];
        }

        long median = 0;
        if (n % 2 == 0) {
            median = arr[n / 2 - 1][0];
        } else {
            median = arr[n / 2][0];
        }

        long ans = 0;
        for (int i = 0; i < n; i++) {
            ans += (long) Math.abs(arr[i][0] - median) * arr[i][1];
        }
        return ans;
    }
}