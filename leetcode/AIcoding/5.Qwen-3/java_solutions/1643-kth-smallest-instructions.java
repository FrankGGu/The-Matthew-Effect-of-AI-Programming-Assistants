public class Solution {

import java.util.*;

public class Solution {
    public String getInstructions(int[] start, int[] destination, int k) {
        int m = destination[0] - start[0];
        int n = destination[1] - start[1];
        int total = m + n;
        char[] res = new char[total];
        int index = 0;
        while (m > 0 || n > 0) {
            if (m == 0) {
                res[index++] = 'R';
                n--;
            } else if (n == 0) {
                res[index++] = 'D';
                m--;
            } else {
                long ways = combination(m + n - 1, m - 1);
                if (k <= ways) {
                    res[index++] = 'D';
                    m--;
                } else {
                    res[index++] = 'R';
                    n--;
                    k -= ways;
                }
            }
        }
        return new String(res);
    }

    private long combination(int n, int k) {
        if (k > n || k < 0) return 0;
        if (k == 0 || k == n) return 1;
        k = Math.min(k, n - k);
        long result = 1;
        for (int i = 1; i <= k; i++) {
            result = result * (n - k + i) / i;
        }
        return result;
    }
}
}