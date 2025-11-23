class Solution {
    public int sumOfGoodNumbers(int[] nums) {
        int totalSum = 0;
        for (int num : nums) {
            if (isGood(num)) {
                totalSum += num;
            }
        }
        return totalSum;
    }

    private boolean isGood(int num) {
        if (num <= 1) {
            return false;
        }
        for (int i = 2; i * i <= num; i++) {
            if (num % i == 0) {
                return false;
            }
        }
        return true;
    }
}