class Solution {
    public int minimizeSum(int[] nums) {
        int n = nums.length;
        int sum = 0;
        for (int i = 0; i < n; i++) {
            while (nums[i] >= 10) {
                int digitSum = 0;
                int temp = nums[i];
                while (temp > 0) {
                    digitSum += temp % 10;
                    temp /= 10;
                }
                nums[i] = digitSum;
            }
            sum += nums[i];
        }
        return sum;
    }
}