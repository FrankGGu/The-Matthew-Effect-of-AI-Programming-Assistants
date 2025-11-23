class Solution {
    long MOD = 1_000_000_007;
    long[] fact;
    long[] invFact;

    public int makeStringSorted(String s) {
        int n = s.length();

        // Precompute factorials and inverse factorials
        fact = new long[n + 1];
        invFact = new long[n + 1];
        fact[0] = 1;
        invFact[0] = 1;
        for (int i = 1; i <= n; i++) {
            fact[i] = (fact[i - 1] * i) % MOD;
        }

        // Compute inverse factorials using invFact[N] = power(fact[N], MOD - 2)
        // and then invFact[i] = invFact[i+1] * (i+1) % MOD for i from N-1 down to 1.
        invFact[n] = power(fact[n], MOD - 2);
        for (int i = n - 1; i >= 1; i--) {
            invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
        }

        int[] counts = new int[26];
        for (char c : s.toCharArray()) {
            counts[c - 'a']++;
        }

        long ans = 0;

        for (int i = 0; i < n; i++) {
            int current_char_idx = s.charAt(i) - 'a';

            // Calculate permutations of the remaining suffix (N - 1 - i)!
            long num_perms_suffix = fact[n - 1 - i];

            // Calculate denominator for repeated characters: product of (count[k]!) for all k
            long denominator = 1;
            for (int k = 0; k < 26; k++) {
                denominator = (denominator * invFact[counts[k]]) % MOD;
            }

            // Number of distinct permutations of the remaining characters
            long permutations_for_this_slot = (num_perms_suffix * denominator) % MOD;

            // Count characters smaller than s[i] that are available in the current counts array
            long smaller_chars_count = 0;
            for (int k = 0; k < current_char_idx; k++) {
                smaller_chars_count = (smaller_chars_count + counts[k]) % MOD;
            }

            // Add to total answer: (count of smaller chars) * (permutations of suffix with remaining chars)
            ans = (ans + (smaller_chars_count * permutations_for_this_slot) % MOD) % MOD;

            // Decrement count for the current character as it's now "used"
            counts[current_char_idx]--;
        }

        return (int) ans;
    }

    // Modular exponentiation (base^exp % MOD)
    private long power(long base, long exp) {
        long res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }
}