import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.PriorityQueue;

class Solution {
    public int kthLargestValue(int[][] matrix, int k) {
        int m = matrix.length;
        int n = matrix[0].length;

        int[][] dp = new int[m + 1][n + 1];
        List<Integer> xorValues = new ArrayList<>();

        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                dp[i][j] = matrix[i - 1][j - 1] ^ dp[i - 1][j] ^ dp[i][j - 1] ^ dp[i - 1][j - 1];
                xorValues.add(dp[i][j]);
            }
        }

        PriorityQueue<Integer> minHeap = new PriorityQueue<>();

        for (int val : xorValues) {
            minHeap.offer(val);
            if (minHeap.size() > k) {
                minHeap.poll();
            }
        }

        return minHeap.peek();
    }
}