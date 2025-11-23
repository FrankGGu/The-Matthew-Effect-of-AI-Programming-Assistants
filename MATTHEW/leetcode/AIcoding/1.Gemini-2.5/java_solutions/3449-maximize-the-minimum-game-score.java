class Solution {
    public int maximizeTheMinimumGameScore(int[] nums, int k) {
        long totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        long low = 0;
        long high = totalSum;
        long ans = 0;

        while (low <= high) {
            long mid = low + (high - low) / 2;
            if (check(nums, k, mid)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return (int) ans;
    }

    private boolean check(int[] nums, int k, long targetMinSum) {
        int numSubarrays = 0;
        long currentSum = 0;

        for (int num : nums) {
            currentSum += num;
            if (currentSum >= targetMinSum) {
                numSubarrays++;
                currentSum = 0;
            }
        }
        return numSubarrays >= k;
    }
}