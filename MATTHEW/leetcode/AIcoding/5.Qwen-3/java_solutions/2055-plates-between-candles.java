public class Solution {

import java.util.*;

public class Solution {
    public int[] platesBetweenCandles(String s, int[][] queries) {
        int n = s.length();
        int[] left = new int[n];
        int[] right = new int[n];
        int[] prefix = new int[n];

        int last = -1;
        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == '*') {
                prefix[i] = 0;
            } else {
                prefix[i] = 0;
                if (last != -1) {
                    prefix[i] = prefix[i - 1] + 1;
                }
            }
            left[i] = last;
            if (s.charAt(i) == '|') {
                last = i;
            }
        }

        last = -1;
        for (int i = n - 1; i >= 0; i--) {
            right[i] = last;
            if (s.charAt(i) == '|') {
                last = i;
            }
        }

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int l = queries[i][0];
            int r = queries[i][1];
            if (l >= r) {
                result[i] = 0;
                continue;
            }
            int leftCandle = right[l];
            int rightCandle = left[r];
            if (leftCandle == -1 || rightCandle == -1 || leftCandle >= rightCandle) {
                result[i] = 0;
            } else {
                result[i] = prefix[rightCandle] - prefix[leftCandle];
            }
        }
        return result;
    }
}
}