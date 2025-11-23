public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> findFarmland(int[][] land) {
        int m = land.length;
        int n = land[0].length;
        boolean[][] visited = new boolean[m][n];
        List<List<Integer>> result = new ArrayList<>();

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (land[i][j] == 1 && !visited[i][j]) {
                    int x = i;
                    int y = j;
                    while (x < m && land[x][j] == 1) {
                        x++;
                    }
                    while (y < n && land[i][y] == 1) {
                        y++;
                    }
                    for (int a = i; a < x; a++) {
                        for (int b = j; b < y; b++) {
                            visited[a][b] = true;
                        }
                    }
                    result.add(Arrays.asList(i, j, x - 1, y - 1));
                }
            }
        }
        return result;
    }
}
}