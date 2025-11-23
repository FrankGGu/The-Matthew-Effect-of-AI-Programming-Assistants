import java.util.*;

public class Solution {
    public int countBalancedPermutations(int n) {
        if (n % 2 != 0) return 0;
        long mod = 1000000007;
        long factorial = 1;
        for (int i = 1; i <= n; i++) {
            factorial = factorial * i % mod;
        }
        long halfFactorial = 1;
        for (int i = 1; i <= n / 2; i++) {
            halfFactorial = halfFactorial * i % mod;
        }
        long invHalfFactorial = modInverse(halfFactorial, mod);
        return (int) (factorial * invHalfFactorial % mod * invHalfFactorial % mod);
    }

    private long modInverse(long a, long mod) {
        return pow(a, mod - 2, mod);
    }

    private long pow(long x, long y, long p) {
        long res = 1;
        x = x % p;
        while (y > 0) {
            if ((y & 1) == 1) res = res * x % p;
            y = y >> 1;
            x = x * x % p;
        }
        return res;
    }
}