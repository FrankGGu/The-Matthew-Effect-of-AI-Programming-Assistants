public class Solution {

import java.util.Arrays;

public class Solution {
    public int sumSubseqWidths(int[] A) {
        Arrays.sort(A);
        int n = A.length;
        long mod = (long) 1e9 + 7;
        long[] pow2 = new long[n];
        pow2[0] = 1;
        for (int i = 1; i < n; i++) {
            pow2[i] = (pow2[i - 1] * 2) % mod;
        }
        long result = 0;
        for (int i = 0; i < n; i++) {
            result = (result + (A[i] * (pow2[i] - 1)) % mod - (A[i] * (pow2[n - 1 - i] - 1)) % mod + mod) % mod;
        }
        return (int) result;
    }
}
}