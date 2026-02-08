import java.util.TreeMap;

class Solution {
    public int minimizeManhattanDistance(int[][] points) {
        int n = points.length;

        int[] u = new int[n]; // x + y
        int[] v = new int[n]; // x - y

        for (int i = 0; i < n; i++) {
            u[i] = points[i][0] + points[i][1];
            v[i] = points[i][0] - points[i][1];
        }

        TreeMap<Integer, Integer> uCounts = new TreeMap<>();
        TreeMap<Integer, Integer> vCounts = new TreeMap<>();

        for (int i = 0; i < n; i++) {
            uCounts.put(u[i], uCounts.getOrDefault(u[i], 0) + 1);
            vCounts.put(v[i], vCounts.getOrDefault(v[i], 0) + 1);
        }

        int minOverallMaxDiff = Integer.MAX_VALUE;

        for (int i = 0; i < n; i++) {
            // Temporarily remove point i's u and v values
            // Remove u[i]
            uCounts.put(u[i], uCounts.get(u[i]) - 1);
            if (uCounts.get(u[i]) == 0) {
                uCounts.remove(u[i]);
            }

            // Remove v[i]
            vCounts.put(v[i], vCounts.get(v[i]) - 1);
            if (vCounts.get(v[i]) == 0) {
                vCounts.remove(v[i]);
            }

            // Calculate max Manhattan distance for the remaining points
            int currentMaxU = uCounts.lastKey();
            int currentMinU = uCounts.firstKey();
            int currentMaxV = vCounts.lastKey();
            int currentMinV = vCounts.firstKey();

            int maxDiff = Math.max(currentMaxU - currentMinU, currentMaxV - currentMinV);
            minOverallMaxDiff = Math.min(minOverallMaxDiff, maxDiff);

            // Add back point i's u and v values for the next iteration
            uCounts.put(u[i], uCounts.getOrDefault(u[i], 0) + 1);
            vCounts.put(v[i], vCounts.getOrDefault(v[i], 0) + 1);
        }

        return minOverallMaxDiff;
    }
}