import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int[] maxPoints(int[][] grid, int[] queries) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] qWithIdx = new int[queries.length][2];
        for (int i = 0; i < queries.length; i++) {
            qWithIdx[i][0] = queries[i];
            qWithIdx[i][1] = i;
        }
        Arrays.sort(qWithIdx, (a, b) -> a[0] - b[0]);
        int[] res = new int[queries.length];
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> grid[a[0]][a[1]] - grid[b[0]][b[1]]);
        pq.offer(new int[]{0, 0});
        boolean[][] visited = new boolean[m][n];
        visited[0][0] = true;
        int[][] dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        int count = 0;
        int idx = 0;
        while (idx < queries.length) {
            while (!pq.isEmpty() && grid[pq.peek()[0]][pq.peek()[1]] < qWithIdx[idx][0]) {
                int[] curr = pq.poll();
                count++;
                for (int[] dir : dirs) {
                    int newRow = curr[0] + dir[0];
                    int newCol = curr[1] + dir[1];
                    if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n && !visited[newRow][newCol]) {
                        pq.offer(new int[]{newRow, newCol});
                        visited[newRow][newCol] = true;
                    }
                }
            }
            res[qWithIdx[idx][1]] = count;
            idx++;
        }
        return res;
    }
}