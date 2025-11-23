public class Solution {

import java.util.Arrays;

public class Solution {
    public long minimumRemoval(int[] beans) {
        Arrays.sort(beans);
        long total = 0;
        for (int bean : beans) {
            total += bean;
        }
        long minRemoval = Long.MAX_VALUE;
        int n = beans.length;
        for (int i = 0; i < n; i++) {
            long current = (long) beans[i] * (n - i);
            minRemoval = Math.min(minRemoval, total - current);
        }
        return minRemoval;
    }
}
}