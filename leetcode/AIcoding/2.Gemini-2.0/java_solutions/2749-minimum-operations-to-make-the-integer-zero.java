class Solution {
    public int makeTheIntegerZero(int num1, int num2) {
        for (int k = 0; k <= 60; k++) {
            long diff = (long) num1 - (long) num2 * k;
            if (diff < k) continue;

            int bits = Long.bitCount(diff);
            if (bits <= k && k <= diff) {
                return k;
            }
        }
        return -1;
    }
}