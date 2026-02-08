class Solution {
    public int countDigitOne(int n) {
        int count = 0;
        for (long k = 1; k <= n; k *= 10) {
            long divider = k * 10;
            count += (n / divider) * k + Math.min(Math.max(n % divider - k + 1, 0), k);
        }
        return count;
    }
}