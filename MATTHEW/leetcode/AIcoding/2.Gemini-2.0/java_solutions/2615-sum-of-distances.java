class Solution {
    public int[] sumOfDistances(int[] nums) {
        int n = nums.length;
        int[] result = new int[] {0};
        if (n == 0) {
            return result;
        }
        result = new int[n];
        for (int i = 0; i < n; i++) {
            long sum = 0;
            for (int j = 0; j < n; j++) {
                sum += Math.abs(nums[i] - nums[j]);
            }
            result[i] = (int) sum;
        }
        return result;
    }
}