class Solution {
    public boolean canDivideIntoSubarrays(int[] nums, int k) {
        int n = nums.length;
        if (n % k != 0) {
            return false;
        }
        int m = n / k;
        for (int i = 1; i < m; i++) {
            for (int j = 0; j < k; j++) {
                int idx = i * k + j;
                if (nums[idx] <= nums[idx - 1]) {
                    return false;
                }
            }
        }
        return true;
    }
}