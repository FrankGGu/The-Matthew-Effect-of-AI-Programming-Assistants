public class Solution {
    public long makeIntegerBeautiful(long n) {
        long original = n;
        long add = 0;
        int digits = 0;
        while (n > 0) {
            digits++;
            n /= 10;
        }
        for (int i = 1; i <= digits; i++) {
            long next = (long) Math.pow(10, i);
            long remainder = original % next;
            if (remainder != 0) {
                add = next - remainder;
                break;
            }
        }
        return add;
    }
}