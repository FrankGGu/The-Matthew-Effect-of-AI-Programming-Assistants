public class Solution {

import java.util.*;

public class Solution {
    public String findTheString(int[][] lcp, int n) {
        char[] result = new char[n];
        Arrays.fill(result, 'a');

        for (int i = 0; i < n; i++) {
            if (result[i] == 'a') {
                for (int j = i + 1; j < n; j++) {
                    if (lcp[i][j] > 0) {
                        result[j] = (char) ('a' + (j - i));
                    }
                }
            }
        }

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (lcp[i][j] > 0 && result[i] != result[j]) {
                    return "";
                }
            }
        }

        return new String(result);
    }
}
}