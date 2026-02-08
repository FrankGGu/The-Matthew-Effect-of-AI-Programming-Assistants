class Solution {
    public int minimumDigitSum(int num) {
        int minSum = Integer.MAX_VALUE;
        for (int i = 0; i <= num; i++) {
            if (i + digitSum(num - i) < minSum) {
                minSum = i + digitSum(num - i);
            }
        }
        return minSum;
    }

    private int digitSum(int n) {
        int sum = 0;
        while (n > 0) {
            sum += n % 10;
            n /= 10;
        }
        return sum;
    }
}