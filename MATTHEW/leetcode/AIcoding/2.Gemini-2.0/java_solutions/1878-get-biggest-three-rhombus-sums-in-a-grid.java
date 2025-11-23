import java.util.PriorityQueue;
import java.util.HashSet;

class Solution {
    public int[] getBiggestThree(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        PriorityQueue<Integer> pq = new PriorityQueue<>();
        HashSet<Integer> seen = new HashSet<>();

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 0; i - k >= 0 && i + k < m && j - k >= 0 && j + k < n; k++) {
                    int sum;
                    if (k == 0) {
                        sum = grid[i][j];
                    } else {
                        sum = 0;
                        for (int l = 0; l <= k; l++) {
                            sum += grid[i - k + l][j + l];
                            sum += grid[i - k + l][j - l];
                            sum += grid[i + k - l][j + l];
                            sum += grid[i + k - l][j - l];
                        }
                        sum -= grid[i - k][j - k];
                        sum -= grid[i - k][j + k];
                        sum -= grid[i + k][j - k];
                        sum -= grid[i + k][j + k];
                    }

                    if (!seen.contains(sum)) {
                        seen.add(sum);
                        if (pq.size() < 3) {
                            pq.offer(sum);
                        } else if (sum > pq.peek()) {
                            pq.poll();
                            pq.offer(sum);
                        }
                    }
                }
            }
        }

        int size = pq.size();
        int[] result = new int[size];
        for (int i = size - 1; i >= 0; i--) {
            result[i] = pq.poll();
        }

        return result;
    }
}