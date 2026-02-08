class Solution {
    public int numOfWays(int n) {
        long aba = 6; 
        long abc = 6; 
        long MOD = 1_000_000_007;

        for (int i = 2; i <= n; i++) {
            long new_aba = (3 * aba + 2 * abc) % MOD;
            long new_abc = (2 * aba + 2 * abc) % MOD;
            aba = new_aba;
            abc = new_abc;
        }

        return (int) ((aba + abc) % MOD);
    }
}