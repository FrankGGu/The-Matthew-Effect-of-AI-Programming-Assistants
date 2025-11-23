class Solution {
    public int differenceOfSum(int[] nums) {
        int sum = 0, digitSum = 0;
        for (int num : nums) {
            sum += num;
            digitSum += sumOfDigits(num);
        }
        return Math.abs(sum - digitSum);
    }

    private int sumOfDigits(int num) {
        int sum = 0;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        return sum;
    }
}