import java.util.PriorityQueue;

public class Solution {
    public int kthSmallest(int[][] mat, int k) {
        int m = mat.length, n = mat[0].length;
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        pq.offer(new int[]{0, 0});
        int[] sums = new int[m];
        for (int j = 0; j < m; j++) {
            sums[j] = mat[j][0];
        }
        for (int i = 0; i < k - 1; i++) {
            int[] curr = pq.poll();
            int sum = curr[0], row = curr[1];
            for (int j = 0; j < n; j++) {
                if (row + 1 < m) {
                    int newSum = sum - mat[row][0] + mat[row + 1][j];
                    pq.offer(new int[]{newSum, row + 1});
                }
            }
        }
        return pq.poll()[0];
    }
}