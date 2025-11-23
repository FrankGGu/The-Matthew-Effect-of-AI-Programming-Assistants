class Solution {
    public int minCapability(int[] nums, int k) {
        int low = 1;
        int high = 1_000_000_000;
        int ans = high;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (check(nums, k, mid)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }

    private boolean check(int[] nums, int k, int max_money) {
        int count = 0;
        int i = 0;
        while (i < nums.length) {
            if (nums[i] <= max_money) {
                count++;
                i += 2;
            } else {
                i++;
            }
            if (count >= k) {
                return true;
            }
        }
        return count >= k;
    }
}