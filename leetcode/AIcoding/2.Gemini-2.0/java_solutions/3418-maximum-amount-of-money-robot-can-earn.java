class Solution {
    public long maximumRobots(int[] chargeTimes, int[] runningCosts, long budget) {
        int n = chargeTimes.length;
        int left = 0, right = n;
        long ans = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (isPossible(chargeTimes, runningCosts, budget, mid)) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return ans;
    }

    private boolean isPossible(int[] chargeTimes, int[] runningCosts, long budget, int k) {
        if (k == 0) return true;

        long currentSum = 0;
        int maxChargeTime = 0;
        int left = 0;
        long sumOfRunningCosts = 0;

        for (int right = 0; right < chargeTimes.length; right++) {
            maxChargeTime = Math.max(maxChargeTime, chargeTimes[right]);
            sumOfRunningCosts += runningCosts[right];

            if (right - left + 1 == k) {
                long cost = maxChargeTime + (sumOfRunningCosts * 1L);
                if (cost > budget) {
                    return false;
                }

                if (right < chargeTimes.length - 1) {
                    sumOfRunningCosts -= runningCosts[left];
                    left++;
                    maxChargeTime = 0;
                    for(int i = left; i <= right; i++){
                        maxChargeTime = Math.max(maxChargeTime, chargeTimes[i]);
                    }
                }
            }
        }
        long currentRunningCostSum = 0;
        int currentMaxChargeTime = 0;
        for (int i = 0; i < k; i++) {
            currentRunningCostSum += runningCosts[i];
            currentMaxChargeTime = Math.max(currentMaxChargeTime, chargeTimes[i]);
        }
        return currentMaxChargeTime + (currentRunningCostSum * 1L) <= budget;
    }
}