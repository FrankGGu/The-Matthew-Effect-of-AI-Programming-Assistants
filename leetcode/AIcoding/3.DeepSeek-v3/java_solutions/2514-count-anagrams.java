import java.util.HashMap;
import java.util.Map;

class Solution {
    private static final int MOD = 1_000_000_007;
    private static final int MAX_LEN = 100_000;
    private static long[] factorial = new long[MAX_LEN + 1];
    private static long[] invFactorial = new long[MAX_LEN + 1];

    static {
        factorial[0] = 1;
        for (int i = 1; i <= MAX_LEN; i++) {
            factorial[i] = (factorial[i - 1] * i) % MOD;
        }
        invFactorial[MAX_LEN] = modInverse(factorial[MAX_LEN], MOD);
        for (int i = MAX_LEN - 1; i >= 0; i--) {
            invFactorial[i] = (invFactorial[i + 1] * (i + 1)) % MOD;
        }
    }

    private static long modInverse(long a, int mod) {
        return power(a, mod - 2, mod);
    }

    private static long power(long a, int b, int mod) {
        long res = 1;
        a %= mod;
        while (b > 0) {
            if ((b & 1) == 1) {
                res = (res * a) % mod;
            }
            a = (a * a) % mod;
            b >>= 1;
        }
        return res;
    }

    public int countAnagrams(String s) {
        String[] words = s.split(" ");
        long result = 1;
        for (String word : words) {
            result = (result * computePermutations(word)) % MOD;
        }
        return (int) result;
    }

    private long computePermutations(String word) {
        Map<Character, Integer> freq = new HashMap<>();
        for (char c : word.toCharArray()) {
            freq.put(c, freq.getOrDefault(c, 0) + 1);
        }
        long res = factorial[word.length()];
        for (int count : freq.values()) {
            res = (res * invFactorial[count]) % MOD;
        }
        return res;
    }
}