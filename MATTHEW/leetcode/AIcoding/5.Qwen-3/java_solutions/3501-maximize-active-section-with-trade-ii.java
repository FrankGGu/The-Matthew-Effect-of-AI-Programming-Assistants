public class Solution {

import java.util.*;

public class Solution {
    public int maxActiveSections(int[] trades) {
        int n = trades.length;
        int[] prefix = new int[n];
        int[] suffix = new int[n];

        prefix[0] = trades[0];
        for (int i = 1; i < n; i++) {
            prefix[i] = prefix[i - 1] + trades[i];
        }

        suffix[n - 1] = trades[n - 1];
        for (int i = n - 2; i >= 0; i--) {
            suffix[i] = suffix[i + 1] + trades[i];
        }

        int max = 0;
        for (int i = 0; i < n; i++) {
            int left = i > 0 ? prefix[i - 1] : 0;
            int right = i < n - 1 ? suffix[i + 1] : 0;
            max = Math.max(max, left + right);
        }

        return max;
    }
}
}