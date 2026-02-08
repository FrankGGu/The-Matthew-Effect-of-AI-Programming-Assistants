class Solution {
    public int waysToPartition(int[] nums, int k) {
        int n = nums.length;
        long[] prefixSum = new long[n];
        prefixSum[0] = nums[0];
        for (int i = 1; i < n; i++) {
            prefixSum[i] = prefixSum[i - 1] + nums[i];
        }

        int ans = 0;
        for (int i = 0; i < n - 1; i++) {
            if (prefixSum[i] == prefixSum[n - 1] - prefixSum[i]) {
                ans++;
            }
        }

        int same = 0;
        for (int i = 0; i < n; i++) {
            int diff = k - nums[i];
            long target = prefixSum[n - 1] - diff;
            int count = 0;
            for (int j = 0; j < n - 1; j++) {
                if (prefixSum[j] == target - prefixSum[j]) {
                    count++;
                }
            }
            same = Math.max(same, count);
        }

        long[] originalSum = new long[n];
        originalSum[0] = nums[0];
        for (int i = 1; i < n; i++) {
            originalSum[i] = originalSum[i - 1] + nums[i];
        }

        int originalAns = 0;
        for (int i = 0; i < n - 1; i++) {
            if (originalSum[i] == originalSum[n - 1] - originalSum[i]) {
                originalAns++;
            }
        }

        if(same>originalAns){
            return same;
        }else{

        int maxWays = 0;

        for (int i = 0; i < n; i++) {
            int diff = k - nums[i];

            int ways = 0;
            long newTotalSum = 0;
            for(int j=0; j<n; j++){
                if(i==j){
                    newTotalSum += k;
                }else{
                    newTotalSum += nums[j];
                }
            }

            for (int j = 0; j < n - 1; j++) {
                long leftSum = 0;
                for(int l=0; l<=j; l++){
                    if(i==l){
                        leftSum += k;
                    }else{
                        leftSum += nums[l];
                    }
                }
                if (leftSum == newTotalSum - leftSum) {
                    ways++;
                }
            }
            maxWays = Math.max(maxWays, ways);
        }

        return maxWays;
        }
    }
}