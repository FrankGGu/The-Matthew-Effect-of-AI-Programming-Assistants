import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[] assignBikes(int[][] workers, int[][] bikes) {
        int n = workers.length;
        int m = bikes.length;
        List<int[]>[] buckets = new ArrayList[2001];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                int dist = Math.abs(workers[i][0] - bikes[j][0]) + Math.abs(workers[i][1] - bikes[j][1]);
                if (buckets[dist] == null) {
                    buckets[dist] = new ArrayList<>();
                }
                buckets[dist].add(new int[]{i, j});
            }
        }

        int[] res = new int[n];
        boolean[] workerAssigned = new boolean[n];
        boolean[] bikeAssigned = new boolean[m];

        for (int d = 0; d <= 2000; d++) {
            if (buckets[d] != null) {
                for (int[] pair : buckets[d]) {
                    int worker = pair[0];
                    int bike = pair[1];
                    if (!workerAssigned[worker] && !bikeAssigned[bike]) {
                        res[worker] = bike;
                        workerAssigned[worker] = true;
                        bikeAssigned[bike] = true;
                    }
                }
            }
        }

        return res;
    }
}