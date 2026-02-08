class Solution {
    public int countIncreasingSubarrays(int[] nums, int k) {
        int n = nums.length;
        int count = 0;
        int len = 1;
        for (int i = 1; i < n; i++) {
            if (nums[i] > nums[i - 1]) {
                len++;
            } else {
                if (len >= k) {
                    count += (len - k + 1);
                }
                len = 1;
            }
        }
        if (len >= k) {
            count += (len - k + 1);
        }
        return count;
    }
}