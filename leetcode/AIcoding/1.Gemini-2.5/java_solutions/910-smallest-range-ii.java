import java.util.Arrays;

class Solution {
    public int smallestRangeII(int[] A, int K) {
        if (A == null || A.length == 0) {
            return 0;
        }

        Arrays.sort(A);
        int n = A.length;

        int minScore = A[n - 1] - A[0];

        for (int i = 0; i < n - 1; i++) {
            int low = Math.min(A[0] + K, A[i + 1] - K);
            int high = Math.max(A[i] + K, A[n - 1] - K);
            minScore = Math.min(minScore, high - low);
        }

        return minScore;
    }
}