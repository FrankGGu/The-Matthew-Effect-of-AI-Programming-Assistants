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
            long left = prefixSum[n / 2 - 1];
            long right = prefixSum[n / 2];

        } else {
            median = prefixSum[n / 2];
        }

        long l = arr[0][0];
        long r = arr[n-1][0];
        long ans = Long.MAX_VALUE;
        while(l <= r){
            long mid = l + (r-l)/2;
            long cost1 = calculateCost(nums,cost,mid);
            ans = Math.min(ans, cost1);

            long cost2 = calculateCost(nums,cost,mid+1);
            ans = Math.min(ans, cost2);

            if(cost1 < cost2){
                r = mid -1;
            } else {
                l = mid + 1;
            }
        }

        return ans;
    }

    private long calculateCost(int[] nums, int[] cost, long target) {
        long totalCost = 0;
        for (int i = 0; i < nums.length; i++) {
            totalCost += (long) Math.abs(nums[i] - target) * cost[i];
        }
        return totalCost;
    }
}