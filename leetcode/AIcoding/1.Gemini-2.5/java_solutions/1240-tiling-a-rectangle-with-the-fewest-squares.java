import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    int N, M;
    boolean[][] filled;
    Map<List<Integer>, Integer> memo;

    public int tilingRectangle(int n, int m) {
        N = n;
        M = m;
        filled = new boolean[N][M];
        memo = new HashMap<>();

        return dfs();
    }

    private int dfs() {
        int r = -1, c = -1;
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < M; j++) {
                if (!filled[i][j]) {
                    r = i;
                    c = j;
                    break;
                }
            }
            if (r != -1) break;
        }

        if (r == -1) {
            return 0;
        }

        List<Integer> currentGridState = new ArrayList<>(N);
        for (int i = 0; i < N; i++) {
            int rowMask = 0;
            for (int j = 0; j < M; j++) {
                if (filled[i][j]) {
                    rowMask |= (1 << j);
                }
            }
            currentGridState.add(rowMask);
        }

        if (memo.containsKey(currentGridState)) {
            return memo.get(currentGridState);
        }

        int minRes = Integer.MAX_VALUE;

        for (int s = Math.min(N - r, M - c); s >= 1; s--) {
            if (canPlace(r, c, s)) {
                placeSquare(r, c, s, true);
                int res = dfs();
                if (res != Integer.MAX_VALUE) {
                    minRes = Math.min(minRes, 1 + res);
                }
                placeSquare(r, c, s, false);
            }
        }

        memo.put(currentGridState, minRes);
        return minRes;
    }

    private boolean canPlace(int r, int c, int s) {
        for (int i = r; i < r + s; i++) {
            for (int j = c; j < c + s; j++) {
                if (filled[i][j]) {
                    return false;
                }
            }
        }
        return true;
    }

    private void placeSquare(int r, int c, int s, boolean fill) {
        for (int i = r; i < r + s; i++) {
            for (int j = c; j < c + s; j++) {
                filled[i][j] = fill;
            }
        }
    }
}