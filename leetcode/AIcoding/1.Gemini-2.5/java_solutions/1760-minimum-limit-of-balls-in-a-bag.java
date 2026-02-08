class Solution {
    public int minimumLimit(int[] nums, int maxOperations) {
        int low = 1;
        int high = 0;
        for (int num : nums) {
            high = Math.max(high, num);
        }

        int ans = high;

        while (low <= high) {
            int mid = low + (high - low) / 2;

            if (canAchieve(nums, maxOperations, mid)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }

    private boolean canAchieve(int[] nums, int maxOperations, int limit) {
        long opsNeeded = 0;
        for (int num : nums) {
            if (num > limit) {
                opsNeeded += (num - 1) / limit;
            }
            if (opsNeeded > maxOperations) {
                return false;
            }
        }
        return opsNeeded <= maxOperations;
    }
}