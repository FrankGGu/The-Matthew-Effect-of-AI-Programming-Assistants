class Solution {
    public long minCost(int[] nums, int[] cost) {
        int n = nums.length;
        int[][] pairs = new int[n][2];
        for (int i = 0; i < n; i++) {
            pairs[i][0] = nums[i];
            pairs[i][1] = cost[i];
        }

        Arrays.sort(pairs, (a, b) -> a[0] - b[0]);

        long[] prefixCost = new long[n];
        prefixCost[0] = pairs[0][1];
        for (int i = 1; i < n; i++) {
            prefixCost[i] = prefixCost[i - 1] + pairs[i][1];
        }

        long median = 0;
        if (n % 2 == 0) {
            long left = prefixCost[n / 2 - 1];
            long right = prefixCost[n / 2];

            long lval = pairs[n/2 -1][0];
            long rval = pairs[n/2][0];

            median = pairs[n/2 -1][0];

        } else {
            median = pairs[n / 2][0];
        }

        long totalCost = 0;
        for (int i = 0; i < n; i++) {
            totalCost += (long) Math.abs(nums[i] - median) * cost[i];
        }

        long ans = totalCost;

        long left = pairs[0][0];
        long right = pairs[n-1][0];

        long low = left;
        long high = right;

        while(low < high){
            long mid = low + (high - low) / 2;
            long cost1 = 0;
            long cost2 = 0;
             for (int i = 0; i < n; i++) {
                cost1 += (long) Math.abs(nums[i] - mid) * cost[i];
                cost2 += (long) Math.abs(nums[i] - (mid+1)) * cost[i];
            }

            if(cost1 < cost2){
                high = mid;
                ans = cost1;
            }else{
                low = mid + 1;
                ans = cost2;
            }
        }

        return ans;
    }
}