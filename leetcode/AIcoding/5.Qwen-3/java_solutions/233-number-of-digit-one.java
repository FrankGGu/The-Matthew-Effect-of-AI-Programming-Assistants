public class Solution {
    public int countDigitOne(int n) {
        int count = 0;
        int i = 1;
        while (i <= n) {
            int divider = i * 10;
            count += (n / divider) * i;
            int remainder = n % i;
            if (remainder >= i) {
                count += i;
            } else {
                count += remainder + 1;
            }
            i *= 10;
        }
        return count;
    }
}