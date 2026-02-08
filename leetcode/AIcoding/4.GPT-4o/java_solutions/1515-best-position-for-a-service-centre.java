import java.util.Arrays;

public class Solution {
    public int bestPosition(int[][] locations) {
        int n = locations.length;
        int bestPos = 0;
        double minDistance = Double.MAX_VALUE;

        for (int i = 0; i < n; i++) {
            double totalDistance = 0;
            for (int j = 0; j < n; j++) {
                totalDistance += Math.sqrt(Math.pow(locations[i][0] - locations[j][0], 2) + 
                                            Math.pow(locations[i][1] - locations[j][1], 2));
            }
            if (totalDistance < minDistance) {
                minDistance = totalDistance;
                bestPos = i;
            }
        }
        return bestPos;
    }
}