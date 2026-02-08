import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;
import java.util.Set;
import java.util.TreeSet;
import java.util.ArrayList;
import java.util.Iterator;

class Solution {
    public int minimumVisitedCells(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        if (m == 1 && n == 1) {
            return 1;
        }

        int[][] dist = new int[m][n];
        for (int i = 0; i < m; i++) {
            Arrays.fill(dist[i], Integer.MAX_VALUE);
        }

        dist[0][0] = 1;
        Queue<int[]> q = new LinkedList<>();
        q.offer(new int[]{0, 0});

        TreeSet<Integer>[] rows = new TreeSet[m];
        TreeSet<Integer>[] cols = new TreeSet[n];

        for (int i = 0; i < m; i++) {
            rows[i] = new TreeSet<>();
            for (int j = 0; j < n; j++) {
                rows[i].add(j);
            }
        }
        for (int j = 0; j < n; j++) {
            cols[j] = new TreeSet<>();
            for (int i = 0; i < m; i++) {
                cols[j].add(i);
            }
        }

        rows[0].remove(0);
        cols[0].remove(0);

        while (!q.isEmpty()) {
            int[] curr = q.poll();
            int r = curr[0];
            int c = curr[1];
            int d = dist[r][c];

            if (r == m - 1 && c == n - 1) {
                return d;
            }

            // Process horizontal moves
            int limit_c = c + grid[r][c];
            List<Integer> visitedColsInRowR = new ArrayList<>();

            Iterator<Integer> it_cols = rows[r].tailSet(c + 1).iterator();
            while (it_cols.hasNext()) {
                int next_c = it_cols.next();
                if (next_c > limit_c) {
                    break;
                }

                if (dist[r][next_c] == Integer.MAX_VALUE) {
                    dist[r][next_c] = d + 1;
                    q.offer(new int[]{r, next_c});
                    cols[next_c].remove(r);
                }
                visitedColsInRowR.add(next_c);
            }
            rows[r].removeAll(visitedColsInRowR);

            // Process vertical moves
            int limit_r = r + grid[r][c];
            List<Integer> visitedRowsInColC = new ArrayList<>();

            Iterator<Integer> it_rows = cols[c].tailSet(r + 1).iterator();
            while (it_rows.hasNext()) {
                int next_r = it_rows.next();
                if (next_r > limit_r) {
                    break;
                }

                if (dist[next_r][c] == Integer.MAX_VALUE) {
                    dist[next_r][c] = d + 1;
                    q.offer(new int[]{next_r, c});
                    rows[next_r].remove(c);
                }
                visitedRowsInColC.add(next_r);
            }
            cols[c].removeAll(visitedRowsInColC);
        }

        return -1;
    }
}