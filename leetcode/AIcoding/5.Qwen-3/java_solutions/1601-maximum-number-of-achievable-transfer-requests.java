public class Solution {

import java.util.*;

public class Solution {
    public int maximumRequests(int n, int[][] requests) {
        int m = requests.length;
        int max = 0;
        for (int mask = 1; mask < (1 << m); mask++) {
            int[] degree = new int[n];
            int count = 0;
            for (int i = 0; i < m; i++) {
                if ((mask & (1 << i)) != 0) {
                    degree[requests[i][0]]++;
                    degree[requests[i][1]]--;
                    count++;
                }
            }
            boolean valid = true;
            for (int i = 0; i < n; i++) {
                if (degree[i] != 0) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                max = Math.max(max, count);
            }
        }
        return max;
    }
}
}