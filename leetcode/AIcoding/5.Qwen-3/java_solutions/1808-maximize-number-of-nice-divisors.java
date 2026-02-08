public class Solution {

import java.util.*;

public class Solution {
    public int maxNiceDivisors(int n) {
        int MOD = 1000000007;
        if (n == 1) return 1;
        if (n == 2) return 2;
        if (n == 3) return 3;

        long result = 1;
        int remainder = n % 3;
        int quotient = n / 3;

        if (remainder == 0) {
            result = pow(3, quotient, MOD);
        } else if (remainder == 1) {
            result = (pow(3, quotient - 1, MOD) * 4) % MOD;
        } else {
            result = (pow(3, quotient, MOD) * 2) % MOD;
        }

        return (int) result;
    }

    private long pow(long base, int exponent, int mod) {
        long result = 1;
        while (exponent > 0) {
            if (exponent % 2 == 1) {
                result = (result * base) % mod;
            }
            base = (base * base) % mod;
            exponent /= 2;
        }
        return result;
    }
}
}