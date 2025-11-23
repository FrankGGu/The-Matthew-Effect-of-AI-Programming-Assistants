class Solution {
    public int minimizeArrayValue(int[] nums) {
        int low = 0;
        int high = 0;
        for (int num : nums) {
            high = Math.max(high, num);
        }

        int ans = high;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (check(mid, nums)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        return ans;
    }

    private boolean check(int x, int[] nums) {
        long[] arr = new long[nums.length];
        for (int i = 0; i < nums.length; i++) {
            arr[i] = nums[i];
        }

        for (int i = nums.length - 1; i > 0; i--) {
            if (arr[i] > x) {
                long diff = arr[i] - x;
                arr[i - 1] += diff;
            }
        }

        return arr[0] <= x;
    }
}