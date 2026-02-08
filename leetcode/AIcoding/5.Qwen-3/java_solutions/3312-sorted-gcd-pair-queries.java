public class Solution {

import java.util.*;

public class Solution {
    public int[] sortGcdPairs(int n, int[][] queries) {
        List<int[]> pairs = new ArrayList<>();
        for (int a = 1; a <= n; a++) {
            for (int b = a + 1; b <= n; b++) {
                if (gcd(a, b) == 1) {
                    pairs.add(new int[]{a, b});
                }
            }
        }
        Collections.sort(pairs, (x, y) -> {
            if (x[0] != y[0]) return x[0] - y[0];
            return x[1] - y[1];
        });
        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int k = queries[i][0];
            result[i] = pairs.get(k - 1)[1];
        }
        return result;
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}
}