class Solution {
    public int maxSum(int[] nums, int k) {
        int countOne = 0;
        for (int num : nums) {
            if ((num & 1) == 1) {
                countOne++;
            }
        }

        int[] result = new int[nums.length];
        for (int i = 0; i < k; i++) {
            if (countOne > 0) {
                result[i] = 1;
                countOne--;
            } else {
                result[i] = 0;
            }
        }

        long sum = 0;
        long mod = 1000000007;
        for (int num : result) {
            sum = (sum + (long)num * num) % mod;
        }

        return (int) sum;
    }
}