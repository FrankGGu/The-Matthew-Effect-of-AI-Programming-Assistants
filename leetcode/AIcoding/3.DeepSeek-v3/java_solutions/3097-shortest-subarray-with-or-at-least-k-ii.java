class Solution {
    public int minimumSubarrayLength(int[] nums, int k) {
        int n = nums.length;
        int minLen = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            int currentOr = 0;
            for (int j = i; j < n; j++) {
                currentOr |= nums[j];
                if (currentOr >= k) {
                    minLen = Math.min(minLen, j - i + 1);
                    break;
                }
            }
        }
        return minLen == Integer.MAX_VALUE ? -1 : minLen;
    }
}