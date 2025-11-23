public class Solution {

import java.util.*;

public class Solution {
    public int[] assignBikes(int[][] workers, int[][] bikes) {
        int n = workers.length;
        int m = bikes.length;
        int[] result = new int[n];
        boolean[] used = new boolean[m];
        List<int[]> list = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                int dist = Math.abs(workers[i][0] - bikes[j][0]) + Math.abs(workers[i][1] - bikes[j][1]);
                list.add(new int[]{dist, i, j});
            }
        }

        list.sort((a, b) -> a[0] != b[0] ? a[0] - b[0] : a[1] - b[1]);

        for (int[] item : list) {
            int dist = item[0];
            int worker = item[1];
            int bike = item[2];
            if (!used[bike] && result[worker] == 0) {
                result[worker] = bike + 1;
                used[bike] = true;
            }
        }

        return result;
    }
}
}