import java.util.Arrays;

class Solution {
    public int countWays(int[][] ranges) {
        Arrays.sort(ranges, (a, b) -> a[0] - b[0]);
        int count = 1;
        int end = ranges[0][1];
        for (int i = 1; i < ranges.length; i++) {
            if (ranges[i][0] > end) {
                count++;
            }
            end = Math.max(end, ranges[i][1]);
        }

        long result = 1;
        long mod = 1000000007;
        for (int i = 0; i < count; i++) {
            result = (result * 2) % mod;
        }

        return (int) result;
    }
}