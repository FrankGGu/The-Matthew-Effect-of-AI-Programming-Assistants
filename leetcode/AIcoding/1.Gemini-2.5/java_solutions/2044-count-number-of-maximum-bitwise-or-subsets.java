class Solution {
    public int countMaxOrSubsets(int[] nums) {
        int n = nums.length;
        int maxOR = 0;
        for (int num : nums) {
            maxOR |= num;
        }

        int count = 0;
        for (int i = 0; i < (1 << n); i++) {
            int currentOR = 0;
            for (int j = 0; j < n; j++) {
                if (((i >> j) & 1) == 1) {
                    currentOR |= nums[j];
                }
            }
            if (currentOR == maxOR) {
                count++;
            }
        }
        return count;
    }
}