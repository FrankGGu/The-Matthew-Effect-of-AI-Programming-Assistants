import java.math.BigInteger;

class Solution {
    private static final int MOD = 1_000_000_007;
    private static final int MAX_CHAR = 26;
    private BigInteger[] factorial;
    private BigInteger[] invFactorial;

    public int makeStringSorted(String s) {
        int n = s.length();
        precomputeFactorials(n);

        int[] freq = new int[MAX_CHAR];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }

        long result = 0;
        for (int i = 0; i < n; i++) {
            char currentChar = s.charAt(i);
            for (int j = 0; j < (currentChar - 'a'); j++) {
                if (freq[j] == 0) continue;

                freq[j]--;
                long temp = computePermutation(freq);
                result = (result + temp) % MOD;
                freq[j]++;
            }
            freq[currentChar - 'a']--;
        }
        return (int) result;
    }

    private void precomputeFactorials(int n) {
        factorial = new BigInteger[n + 1];
        invFactorial = new BigInteger[n + 1];
        factorial[0] = BigInteger.ONE;
        for (int i = 1; i <= n; i++) {
            factorial[i] = factorial[i - 1].multiply(BigInteger.valueOf(i));
        }
        invFactorial[n] = factorial[n].modInverse(BigInteger.valueOf(MOD));
        for (int i = n - 1; i >= 0; i--) {
            invFactorial[i] = invFactorial[i + 1].multiply(BigInteger.valueOf(i + 1)).mod(BigInteger.valueOf(MOD));
        }
    }

    private long computePermutation(int[] freq) {
        BigInteger denominator = BigInteger.ONE;
        int total = 0;
        for (int count : freq) {
            if (count == 0) continue;
            denominator = denominator.multiply(invFactorial[count]);
            total += count;
        }
        BigInteger res = factorial[total].multiply(denominator).mod(BigInteger.valueOf(MOD));
        return res.longValue();
    }
}