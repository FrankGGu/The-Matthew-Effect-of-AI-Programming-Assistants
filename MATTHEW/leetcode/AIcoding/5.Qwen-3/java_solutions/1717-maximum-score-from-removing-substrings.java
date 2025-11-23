public class Solution {
    public int maximumScore(String s, int[] A, int[] B) {
        int n = s.length();
        int m = A.length;
        int[] dp = new int[n];
        for (int i = 0; i < n; i++) {
            dp[i] = 1;
        }
        for (int i = 0; i < m; i++) {
            int a = A[i];
            int b = B[i];
            if (a > b) {
                int temp = a;
                a = b;
                b = temp;
            }
            for (int j = a; j <= b; j++) {
                dp[j] += 1;
            }
        }
        int max = 0;
        for (int i = 0; i < n; i++) {
            max = Math.max(max, dp[i]);
        }
        return max;
    }
}