class Solution {
    public int findTheArrayConcVal(int[] nums) {
        int n = nums.length;
        int sum = 0;
        for (int i = 0; i < (n + 1) / 2; i++) {
            if (i != n - 1 - i) {
                sum += Integer.parseInt(String.valueOf(nums[i]) + String.valueOf(nums[n - 1 - i]));
            } else {
                sum += nums[i];
            }
        }
        return sum;
    }
}