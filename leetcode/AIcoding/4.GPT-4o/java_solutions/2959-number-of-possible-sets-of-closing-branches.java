public class Solution {
    public int countSets(int n) {
        final int MOD = 1_000_000_007;
        long result = 1;
        for (int i = 1; i <= n; i++) {
            result = (result * (2 * i)) % MOD;
        }
        return (int) result;
    }
}