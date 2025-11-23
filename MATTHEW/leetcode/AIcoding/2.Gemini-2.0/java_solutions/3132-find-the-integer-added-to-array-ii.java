class Solution {
    public int findTheIntegerAddedToArray(int[] nums, int k) {
        int n = nums.length;
        int left = 0, right = (int) 1e5;
        int ans = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            long sum = 0;
            for (int num : nums) {
                sum += Math.max(0, mid - num);
            }

            if (sum <= k) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return ans;
    }
}