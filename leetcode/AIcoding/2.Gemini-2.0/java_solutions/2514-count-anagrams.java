class Solution {
    private static final int MOD = 1_000_000_007;

    public int countAnagrams(String s) {
        String[] words = s.split(" ");
        long result = 1;
        int totalLength = 0;
        for (String word : words) {
            int n = word.length();
            totalLength += n;
            long[] factorial = new long[n + 1];
            factorial[0] = 1;
            for (int i = 1; i <= n; i++) {
                factorial[i] = (factorial[i - 1] * i) % MOD;
            }

            int[] counts = new int[26];
            for (char c : word.toCharArray()) {
                counts[c - 'a']++;
            }

            long denominator = 1;
            for (int count : counts) {
                denominator = (denominator * factorial[count]) % MOD;
            }

            result = (result * factorial[n]) % MOD;
            result = (result * power(denominator, MOD - 2)) % MOD;
        }

        return (int) result;
    }

    private long power(long base, long exp) {
        long res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp >>= 1;
        }
        return res;
    }
}