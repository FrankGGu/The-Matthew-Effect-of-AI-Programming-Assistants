class Solution {
    public int shortestSubarray(int[] nums, int k) {
        int n = nums.length;
        int ans = n + 1;
        for (int i = 0; i < n; i++) {
            int or = 0;
            for (int j = i; j < n; j++) {
                or |= nums[j];
                if (or >= k) {
                    ans = Math.min(ans, j - i + 1);
                    break;
                }
            }
        }
        return ans > n ? -1 : ans;
    }
}