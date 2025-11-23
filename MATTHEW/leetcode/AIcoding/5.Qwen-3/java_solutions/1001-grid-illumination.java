public class Solution {

import java.util.*;

public class Solution {
    public int[] gridIllumination(int[][] queries, int N) {
        Set<String> lights = new HashSet<>();
        Map<String, Integer> count = new HashMap<>();
        Set<String> seen = new HashSet<>();

        for (int[] query : queries) {
            int x = query[0];
            int y = query[1];
            String key = x + "," + y;
            if (seen.contains(key)) {
                continue;
            }
            seen.add(key);
            boolean isIlluminated = false;
            if (count.containsKey(x + ",") || count.containsKey("," + y) || count.containsKey((x - y) + ",") || count.containsKey((x + y) + ",")) {
                isIlluminated = true;
            }
            if (isIlluminated) {
                int[] result = new int[queries.length];
                int index = 0;
                for (int[] q : queries) {
                    int qx = q[0];
                    int qy = q[1];
                    String qkey = qx + "," + qy;
                    if (seen.contains(qkey)) {
                        result[index++] = 1;
                    } else {
                        result[index++] = 0;
                    }
                }
                return result;
            }
            for (int dx = -1; dx <= 1; dx++) {
                for (int dy = -1; dy <= 1; dy++) {
                    int nx = x + dx;
                    int ny = y + dy;
                    if (nx >= 0 && ny >= 0 && nx < N && ny < N) {
                        String nkey = nx + "," + ny;
                        if (!lights.contains(nkey)) {
                            lights.add(nkey);
                            String row = nx + ",";
                            String col = "," + ny;
                            String diag1 = (nx - ny) + ",";
                            String diag2 = (nx + ny) + ",";
                            count.put(row, count.getOrDefault(row, 0) + 1);
                            count.put(col, count.getOrDefault(col, 0) + 1);
                            count.put(diag1, count.getOrDefault(diag1, 0) + 1);
                            count.put(diag2, count.getOrDefault(diag2, 0) + 1);
                        }
                    }
                }
            }
        }

        int[] result = new int[queries.length];
        Arrays.fill(result, 0);
        return result;
    }
}
}