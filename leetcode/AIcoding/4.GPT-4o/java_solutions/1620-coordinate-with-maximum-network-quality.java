import java.util.Arrays;

class Solution {
    public int[] bestCoordinate(int[][] towers, int radius) {
        int maxQuality = 0;
        int[] bestCoordinate = new int[2];

        for (int x = 0; x <= 50; x++) {
            for (int y = 0; y <= 50; y++) {
                int quality = 0;
                for (int[] tower : towers) {
                    int tx = tower[0];
                    int ty = tower[1];
                    int q = tower[2];
                    double distance = Math.sqrt(Math.pow(x - tx, 2) + Math.pow(y - ty, 2));
                    if (distance <= radius) {
                        quality += q / (1 + distance);
                    }
                }
                if (quality > maxQuality) {
                    maxQuality = quality;
                    bestCoordinate[0] = x;
                    bestCoordinate[1] = y;
                } else if (quality == maxQuality) {
                    if (x < bestCoordinate[0] || (x == bestCoordinate[0] && y < bestCoordinate[1])) {
                        bestCoordinate[0] = x;
                        bestCoordinate[1] = y;
                    }
                }
            }
        }

        return bestCoordinate;
    }
}