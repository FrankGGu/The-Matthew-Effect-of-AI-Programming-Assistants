import java.util.Arrays;

class Solution {
    public long minimumCost(int[] start, int[] target, int[] specialRoads) {
        int sx = start[0], sy = start[1];
        int tx = target[0], ty = target[1];
        int n = specialRoads.length;

        if (n == 0) {
            return Math.abs(sx - tx) + Math.abs(sy - ty);
        }

        long[] dist = new long[n + 2];
        Arrays.fill(dist, Long.MAX_VALUE);
        dist[n] = 0;

        boolean updated = true;
        while (updated) {
            updated = false;
            for (int i = 0; i < n + 2; i++) {
                for (int j = 0; j < n + 2; j++) {
                    long cost;
                    if (i == n) {
                        int x1 = sx, y1 = sy;
                        if (j < n) {
                            int x2 = specialRoads[j][0], y2 = specialRoads[j][1];
                            cost = Math.abs(x1 - x2) + Math.abs(y1 - y2);
                        } else {
                            int x2 = tx, y2 = ty;
                            cost = Math.abs(x1 - x2) + Math.abs(y1 - y2);
                        }
                    } else if (i == n + 1) {
                        continue;
                    } else {
                        int x1 = specialRoads[i][2], y1 = specialRoads[i][3];
                        if (j < n) {
                            int x2 = specialRoads[j][0], y2 = specialRoads[j][1];
                            cost = Math.abs(x1 - x2) + Math.abs(y1 - y2);
                        } else {
                            int x2 = tx, y2 = ty;
                            cost = Math.abs(x1 - x2) + Math.abs(y1 - y2);
                        }
                    }

                    long roadCost;
                    if (i < n && j < n) {
                        roadCost = specialRoads[i][4];
                    } else {
                        roadCost = 0;
                    }

                    if (i < n && j == n) continue;

                    if (dist[i] != Long.MAX_VALUE && dist[i] + Math.min(cost, (i < n) ? specialRoads[i][0] - sx + specialRoads[i][1] - sy + specialRoads[i][2] - specialRoads[i][0] + specialRoads[i][3] - specialRoads[i][1] - cost + specialRoads[i][4] : 0) + roadCost < dist[j]) {
                        dist[j] = dist[i] + Math.min(cost, (i < n) ? specialRoads[i][0] - sx + specialRoads[i][1] - sy + specialRoads[i][2] - specialRoads[i][0] + specialRoads[i][3] - specialRoads[i][1] - cost + specialRoads[i][4] : 0) + roadCost;
                        updated = true;
                    }
                }
            }
        }

        return dist[n + 1];
    }
}