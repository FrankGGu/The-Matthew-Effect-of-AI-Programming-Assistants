public class Solution {

import java.util.*;

public class Solution {
    public int countAnagrams(String s) {
        int MOD = 1000000007;
        int n = s.length();
        long[] fact = new long[n + 1];
        long[] inv_fact = new long[n + 1];

        fact[0] = 1;
        for (int i = 1; i <= n; i++) {
            fact[i] = fact[i - 1] * i % MOD;
        }

        inv_fact[n] = pow(fact[n], MOD - 2, MOD);
        for (int i = n - 1; i >= 0; i--) {
            inv_fact[i] = inv_fact[i + 1] * (i + 1) % MOD;
        }

        int[] freq = new int[26];
        long result = 1;
        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            freq[c - 'a']++;
            if (freq[c - 'a'] == 1) {
                result = result * fact[i] % MOD;
            } else {
                result = result * inv_fact[freq[c - 'a'] - 1] % MOD;
                result = result * inv_fact[freq[c - 'a']] % MOD;
            }
        }
        return (int) result;
    }

    private long pow(long a, long b, long mod) {
        long res = 1;
        while (b > 0) {
            if (b % 2 == 1) {
                res = res * a % mod;
            }
            a = a * a % mod;
            b /= 2;
        }
        return res;
    }
}
}