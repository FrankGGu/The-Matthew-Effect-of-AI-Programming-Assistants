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
            median = (arr[n / 2 - 1][0] + arr[n / 2][0]) / 2;
        } else {
            median = arr[n / 2][0];
        }

        long ans = Long.MAX_VALUE;
        for(int i = 0; i < n; i++){
            long cur = 0;
            for(int j = 0; j < n; j++){
                cur += (long) Math.abs(arr[j][0] - arr[i][0]) * arr[j][1];
            }
            ans = Math.min(ans, cur);
        }

        long medianCost = 0;
        for(int i = 0; i < n; i++){
            medianCost += (long) Math.abs(arr[i][0] - arr[n/2][0]) * arr[i][1];
        }

        return ans;
    }
}