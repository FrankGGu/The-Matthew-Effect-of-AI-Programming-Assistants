public class Solution {

import java.util.Arrays;

public class Solution {
    public int countWays(int[][] ranges) {
        Arrays.sort(ranges, (a, b) -> a[0] - b[0]);
        int n = ranges.length;
        long result = 1;
        int prevEnd = ranges[0][1];
        for (int i = 1; i < n; i++) {
            if (ranges[i][0] > prevEnd) {
                result = (result * 2) % 1000000007;
            }
            prevEnd = Math.max(prevEnd, ranges[i][1]);
        }
        return (int) result;
    }
}
}