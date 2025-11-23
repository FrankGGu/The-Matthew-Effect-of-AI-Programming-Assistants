public class Solution {

import java.util.*;

public class Solution {
    public int getMinOperations(String s) {
        int n = s.length();
        long[] fact = new long[n + 1];
        long[] invFact = new long[n + 1];
        fact[0] = 1;
        for (int i = 1; i <= n; i++) {
            fact[i] = fact[i - 1] * i;
        }
        invFact[n] = modinv(fact[n]);
        for (int i = n - 1; i >= 0; i--) {
            invFact[i] = invFact[i + 1] * (i + 1) % 1000000007;
        }

        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }

        long res = 0;
        for (int i = 0; i < n; i++) {
            int c = s.charAt(i) - 'a';
            long temp = 0;
            for (int j = 0; j < c; j++) {
                if (count[j] > 0) {
                    temp += fact[n - i - 1];
                    temp %= 1000000007;
                }
            }
            for (int j = c; j < 26; j++) {
                if (count[j] > 0) {
                    temp = temp * invFact[count[j]] % 1000000007;
                    count[j]--;
                    break;
                }
            }
            res = (res + temp) % 1000000007;
        }
        return (int) res;
    }

    private long modinv(long a) {
        return pow(a, 1000000005);
    }

    private long pow(long a, long b) {
        long res = 1;
        while (b > 0) {
            if (b % 2 == 1) {
                res = res * a % 1000000007;
            }
            a = a * a % 1000000007;
            b /= 2;
        }
        return res;
    }
}
}