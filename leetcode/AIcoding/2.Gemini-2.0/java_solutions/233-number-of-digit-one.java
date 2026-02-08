class Solution {
    public int countDigitOne(int n) {
        int count = 0;
        long base = 1;
        while (n / base > 0) {
            long high = n / (base * 10);
            long cur = (n / base) % 10;
            long low = n - (n / base) * base;

            if (cur == 0) {
                count += high * base;
            } else if (cur == 1) {
                count += high * base + low + 1;
            } else {
                count += (high + 1) * base;
            }
            base *= 10;
        }
        return count;
    }
}