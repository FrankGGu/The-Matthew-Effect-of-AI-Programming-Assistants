class Solution {
    public int beautifulSubsets(int[] nums, int k) {
        int n = nums.length;
        int result = 0;
        for (int mask = 1; mask < (1 << n); mask++) {
            boolean valid = true;
            for (int i = 0; i < n && valid; i++) {
                if ((mask & (1 << i)) != 0) {
                    for (int j = i + 1; j < n && valid; j++) {
                        if ((mask & (1 << j)) != 0 && Math.abs(nums[i] - nums[j]) == k) {
                            valid = false;
                        }
                    }
                }
            }
            if (valid) {
                result++;
            }
        }
        return result;
    }
}