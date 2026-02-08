import java.util.Arrays;

public class Solution {
    public int countWays(int[][] ranges) {
        Arrays.sort(ranges, (a, b) -> Integer.compare(a[0], b[0]));
        int mod = 1000000007;
        long count = 1;
        int end = ranges[0][1];

        for (int i = 1; i < ranges.length; i++) {
            if (ranges[i][0] <= end) {
                end = Math.max(end, ranges[i][1]);
            } else {
                count = (count * 2) % mod;
                end = ranges[i][1];
            }
        }

        return (int) count;
    }
}