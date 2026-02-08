class Solution {
    public int maxSubarrays(int[] nums) {
        int res = 1;
        int cur = nums[0];
        for (int i = 1; i < nums.length; i++) {
            cur &= nums[i];
        }

        if (cur != 0) {
            return 1;
        }

        cur = nums[0];
        for (int i = 1; i < nums.length; i++) {
            cur &= nums[i];
            if (cur == 0) {
                res++;
                if (i + 1 < nums.length) {
                    cur = nums[i + 1];
                    i++;
                } else {
                    break;
                }
            }
        }
        return res;
    }
}