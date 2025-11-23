public class Solution {

import java.util.*;

public class Solution {
    public int[] distanceToNearestHouse(int[] s) {
        int n = s.length;
        int[] result = new int[n];
        Arrays.fill(result, Integer.MAX_VALUE);

        int prev = -1;
        for (int i = 0; i < n; i++) {
            if (s[i] == 1) {
                prev = i;
                result[i] = 0;
            } else if (prev != -1) {
                result[i] = i - prev;
            }
        }

        prev = -1;
        for (int i = n - 1; i >= 0; i--) {
            if (s[i] == 1) {
                prev = i;
                result[i] = 0;
            } else if (prev != -1) {
                result[i] = Math.min(result[i], prev - i);
            }
        }

        return result;
    }
}
}