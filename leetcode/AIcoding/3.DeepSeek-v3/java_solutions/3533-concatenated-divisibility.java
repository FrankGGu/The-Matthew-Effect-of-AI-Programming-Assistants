class Solution {
    public int concatenatedDivisible(int[] nums, int k) {
        int count = 0;
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (i == j) continue;
                long num = Long.parseLong(nums[i] + "" + nums[j]);
                if (num % k == 0) {
                    count++;
                }
            }
        }
        return count;
    }
}