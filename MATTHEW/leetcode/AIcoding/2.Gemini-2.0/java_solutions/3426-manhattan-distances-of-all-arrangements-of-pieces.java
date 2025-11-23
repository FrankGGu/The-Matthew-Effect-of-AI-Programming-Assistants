import java.util.ArrayList;
import java.util.List;

class Solution {
    public long[] getDistances(int n, int[][] coordinates) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] coordinate : coordinates) {
            int u = coordinate[0];
            int v = coordinate[1];
            adj.get(u).add(v);
        }

        long[] result = new long[coordinates.length];
        for (int i = 0; i < coordinates.length; i++) {
            int x1 = coordinates[i][0];
            int y1 = coordinates[i][1];
            long distance = 0;
            for (int j = 0; j < coordinates.length; j++) {
                if (i != j) {
                    int x2 = coordinates[j][0];
                    int y2 = coordinates[j][1];
                    distance += Math.abs(x1 - x2) + Math.abs(y1 - y2);
                }
            }
            result[i] = distance;
        }
        return result;
    }
}