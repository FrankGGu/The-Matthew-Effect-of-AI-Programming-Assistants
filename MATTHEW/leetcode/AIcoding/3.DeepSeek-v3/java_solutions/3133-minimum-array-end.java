class Solution {
    public long minEnd(int n, int x) {
        long res = x;
        n--;
        for (int i = 0; i < 60 && n > 0; i++) {
            if ((res & (1L << i)) == 0) {
                res |= (long) (n & 1) << i;
                n >>= 1;
            }
        }
        return res;
    }
}