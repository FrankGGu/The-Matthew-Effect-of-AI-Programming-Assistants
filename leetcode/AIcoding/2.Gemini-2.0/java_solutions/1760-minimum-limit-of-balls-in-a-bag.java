class Solution {
    public int minimumSize(int[] nums, int maxOperations) {
        int left = 1;
        int right = 1000000000;
        int ans = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            int operations = 0;
            for (int num : nums) {
                operations += (num - 1) / mid;
            }

            if (operations <= maxOperations) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return ans;
    }
}