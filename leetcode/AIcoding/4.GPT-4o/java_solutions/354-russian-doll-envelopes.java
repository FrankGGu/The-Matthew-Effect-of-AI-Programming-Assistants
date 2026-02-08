import java.util.Arrays;

public class Solution {
    public int maxEnvelopes(int[][] envelopes) {
        Arrays.sort(envelopes, (a, b) -> a[0] == b[0] ? a[1] - b[1] : a[0] - b[0]);
        int n = envelopes.length;
        int[] dp = new int[n];
        int length = 0;

        for (int[] envelope : envelopes) {
            int idx = Arrays.binarySearch(dp, 0, length, envelope[1]);
            if (idx < 0) {
                idx = -(idx + 1);
            }
            dp[idx] = envelope[1];
            if (idx == length) {
                length++;
            }
        }
        return length;
    }
}