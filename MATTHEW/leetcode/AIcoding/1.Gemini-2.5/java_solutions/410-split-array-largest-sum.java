class Solution {
    public int splitArray(int[] nums, int k) {
        long low = 0;
        long high = 0;
        for (int num : nums) {
            high += num;
            if (num > low) {
                low = num;
            }
        }

        long ans = high;

        while (low <= high) {
            long mid = low + (high - low) / 2;
            if (isPossible(nums, k, mid)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return (int) ans;
    }

    private boolean isPossible(int[] nums, int k, long maxSum) {
        int subarrays = 1;
        long currentSum = 0;
        for (int num : nums) {
            if (currentSum + num > maxSum) {
                subarrays++;
                currentSum = num;
            } else {
                currentSum += num;
            }
        }
        return subarrays <= k;
    }
}