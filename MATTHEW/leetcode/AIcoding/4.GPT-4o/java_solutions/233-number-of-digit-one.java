public class Solution {
    public int countDigitOne(int n) {
        if (n <= 0) return 0;
        int count = 0, factor = 1;

        while (factor <= n) {
            int lowerNumbers = n - (n / factor) * factor;
            int currentDigit = (n / factor) % 10;
            int higherNumbers = n / (factor * 10);

            if (currentDigit == 0) {
                count += higherNumbers * factor;
            } else if (currentDigit == 1) {
                count += higherNumbers * factor + lowerNumbers + 1;
            } else {
                count += (higherNumbers + 1) * factor;
            }

            factor *= 10;
        }

        return count;
    }
}