class Solution {
    public boolean concatenatedBinary(int n) {
        long mod = 1000000007;
        long result = 0;
        int length = 0;

        for (int i = 1; i <= n; i++) {
            if ((i & (i - 1)) == 0) {
                length++;
            }
            result = ((result << length) % mod + i) % mod;
        }

        return result == 0;
    }
}