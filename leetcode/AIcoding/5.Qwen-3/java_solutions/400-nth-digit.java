public class Solution {
    public int findNthDigit(int n) {
        int digits = 1;
        long count = 9;
        long start = 1;

        while (n > digits * count) {
            n -= digits * count;
            digits++;
            count *= 10;
            start *= 10;
        }

        start += (n - 1) / digits;
        return Long.toString(start).charAt((n - 1) % digits) - '0';
    }
}