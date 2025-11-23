public class Solution {
    public int countGoodNumbers(long maxLength) {
        long mod = 1000000007;
        long evenCount = 1;
        long oddCount = 1;
        for (int i = 0; i < maxLength; i++) {
            if (i % 2 == 0) {
                evenCount = (evenCount * 5) % mod;
            } else {
                oddCount = (oddCount * 4) % mod;
            }
        }
        return (int) ((evenCount * oddCount) % mod);
    }
}