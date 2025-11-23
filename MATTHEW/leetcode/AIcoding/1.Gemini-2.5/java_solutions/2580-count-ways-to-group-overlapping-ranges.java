import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

class Solution {
    public int countWays(int[][] ranges) {
        if (ranges == null || ranges.length == 0) {
            return 1;
        }

        Arrays.sort(ranges, Comparator.comparingInt(a -> a[0]));

        long distinctRanges = 0;
        long currentEnd = -1; 

        for (int[] range : ranges) {
            int start = range[0];
            int end = range[1];

            if (start > currentEnd) {
                distinctRanges++;
                currentEnd = end;
            } else {
                currentEnd = Math.max(currentEnd, end);
            }
        }

        long MOD = 1_000_000_007;
        return (int) power(2, distinctRanges, MOD);
    }

    private long power(long base, long exp, long mod) {
        long res = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = (res * base) % mod;
            }
            base = (base * base) % mod;
            exp /= 2;
        }
        return res;
    }
}