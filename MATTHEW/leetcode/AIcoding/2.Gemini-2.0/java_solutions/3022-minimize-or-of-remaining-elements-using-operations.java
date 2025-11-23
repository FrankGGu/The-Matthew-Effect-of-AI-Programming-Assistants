class Solution {
    public int minimizeOR(int[] nums, int k) {
        int n = nums.length;
        int ans = Integer.MAX_VALUE;
        for (int i = 0; i < (1 << n); i++) {
            if (Integer.bitCount(i) == k) {
                int orVal = 0;
                for (int j = 0; j < n; j++) {
                    if ((i & (1 << j)) == 0) {
                        orVal |= nums[j];
                    }
                }
                ans = Math.min(ans, orVal);
            }
        }
        return ans;
    }
}