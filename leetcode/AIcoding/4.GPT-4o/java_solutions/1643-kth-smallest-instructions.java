import java.util.*;

class Solution {
    public String kthSmallestPath(int[] destination, int k) {
        int m = destination[0], n = destination[1];
        StringBuilder result = new StringBuilder();
        int totalSteps = m + n;
        int[] comb = new int[totalSteps + 1];

        comb[0] = 1;
        for (int i = 1; i <= totalSteps; i++) {
            comb[i] = comb[i - 1] * i / (i + 1);
        }

        for (int i = 0; i < totalSteps; i++) {
            if (m == 0) {
                result.append('H');
                n--;
            } else if (n == 0) {
                result.append('V');
                m--;
            } else {
                int count = comb[m + n - 1];
                if (k <= count) {
                    result.append('H');
                    m--;
                } else {
                    result.append('V');
                    k -= count;
                    n--;
                }
            }
        }

        return result.toString();
    }
}