public class Solution {
    public int sumOfGoodNumbers(int n) {
        int sum = 0;
        for (int i = 1; i <= n; i++) {
            if (isGoodNumber(i)) {
                sum += i;
            }
        }
        return sum;
    }

    private boolean isGoodNumber(int num) {
        int sum = 0;
        int temp = num;
        while (temp > 0) {
            sum += temp % 10;
            temp /= 10;
        }
        return sum % 3 == 0;
    }
}