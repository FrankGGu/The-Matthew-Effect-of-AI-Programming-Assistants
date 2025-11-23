class Solution {
    public long minCost(int[] nums, int x) {
        int n = nums.length;
        long[] minCosts = new long[n];
        for (int i = 0; i < n; i++) {
            minCosts[i] = Long.MAX_VALUE;
        }

        for (int i = 0; i < n; i++) {
            long currentCost = (long) i * x;
            int[] currentNums = new int[n];
            for (int j = 0; j < n; j++) {
                currentNums[j] = nums[(j + i) % n];
                currentCost += currentNums[j];
            }
            minCosts[0] = Math.min(minCosts[0], currentCost);
        }

        long result = Long.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            long currentCost = (long) i * x;
            long sum = 0;
            for (int j = 0; j < n; j++) {
                int minVal = Integer.MAX_VALUE;
                for (int k = 0; k <= i; k++) {
                    minVal = Math.min(minVal, nums[(j + k) % n]);
                }
                sum += minVal;
            }
            result = Math.min(result, currentCost + sum);
        }

        long result2 = Long.MAX_VALUE;
        for(int i = 0; i < n; i++){
            long cost = (long)i * x;
            long sum = 0;
            for(int j = 0; j < n; j++){
                int min = Integer.MAX_VALUE;
                for(int k = 0; k <= i; k++){
                    min = Math.min(min, nums[(j+k) % n]);
                }
                sum += min;
            }
            result2 = Math.min(result2, cost + sum);
        }

        long res = Long.MAX_VALUE;
        for(int i = 0; i < n; i++){
            long curr = (long) i * x;
            int[] temp = new int[n];
            for(int j = 0; j < n; j++){
                temp[j] = nums[(j + i) % n];
            }

            long s = 0;
            for(int num : temp){
                s += num;
            }
            res = Math.min(res, s + curr);
        }

        long[] minVal = new long[n];
        for(int i = 0; i < n; i++){
            minVal[i] = nums[i];
        }

        long ans = Long.MAX_VALUE;
        for(int i = 0; i < n; i++){
            long cost = (long)i * x;
            long sum = 0;
            for(int j = 0; j < n; j++){
                minVal[j] = Math.min(minVal[j], nums[(j+i) % n]);
                sum += minVal[j];
            }
            ans = Math.min(ans, cost + sum);
        }

        return ans;
    }
}