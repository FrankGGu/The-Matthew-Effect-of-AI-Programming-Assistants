public class Solution {
    public int alternateDigitSum(int n) {
        int sum = 0;
        boolean positive = true;
        while (n > 0) {
            int digit = n % 10;
            if (positive) {
                sum += digit;
            } else {
                sum -= digit;
            }
            positive = !positive;
            n /= 10;
        }
        return sum;
    }
}