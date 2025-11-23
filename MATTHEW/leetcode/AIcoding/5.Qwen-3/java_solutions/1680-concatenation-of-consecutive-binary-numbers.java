public class Solution {
    public int concatenatedBinary(int n) {
        long result = 0;
        int mod = 1000000007;
        for (int i = 1; i <= n; i++) {
            int length = Integer.toBinaryString(i).length();
            result = (result << length) | i;
            result %= mod;
        }
        return (int) result;
    }
}