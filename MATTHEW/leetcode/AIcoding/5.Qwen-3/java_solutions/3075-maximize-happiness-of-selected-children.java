public class Solution {

import java.util.Arrays;

public class Solution {
    public long maximumHappiness(long[] happiness, int k) {
        Arrays.sort(happiness);
        long total = 0;
        for (int i = 0; i < k; i++) {
            total += Math.max(0, happiness[happiness.length - 1 - i] - i);
        }
        return total;
    }
}
}