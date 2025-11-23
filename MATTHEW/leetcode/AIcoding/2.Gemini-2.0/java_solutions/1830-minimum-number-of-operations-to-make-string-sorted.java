class Solution {
    private static final int MOD = 1000000007;

    public int makeStringSorted(String s) {
        int n = s.length();
        long[] fact = new long[n + 1];
        fact[0] = 1;
        for (int i = 1; i <= n; i++) {
            fact[i] = (fact[i - 1] * i) % MOD;
        }

        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }

        long ans = 0;
        for (int i = 0; i < n; i++) {
            int smaller = 0;
            for (int j = 0; j < s.charAt(i) - 'a'; j++) {
                smaller += count[j];
            }

            long denominator = 1;
            for (int j = 0; j < 26; j++) {
                denominator = (denominator * factorialPower(fact, count[j], MOD)) % MOD;
            }

            ans = (ans + (smaller * (fact[n - i - 1] * power(denominator, MOD - 2, MOD)) % MOD) % MOD) % MOD;

            count[s.charAt(i) - 'a']--;
        }

        return (int) ans;
    }

    private long factorialPower(long[] fact, int n, int mod) {
        return fact[n];
    }

    private long power(long base, long exp, long mod) {
        long res = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % mod;
            base = (base * base) % mod;
            exp /= 2;
        }
        return res;
    }
}