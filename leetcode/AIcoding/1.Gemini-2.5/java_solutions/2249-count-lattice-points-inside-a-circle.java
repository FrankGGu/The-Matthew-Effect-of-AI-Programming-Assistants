import java.util.HashSet;
import java.util.Set;

class Solution {
    public int countLatticePoints(int[][] circles) {
        Set<String> latticePoints = new HashSet<>();

        int minX = Integer.MAX_VALUE;
        int maxX = Integer.MIN_VALUE;
        int minY = Integer.MAX_VALUE;
        int maxY = Integer.MIN_VALUE;

        for (int[] circle : circles) {
            int cx = circle[0];
            int cy = circle[1];
            int r = circle[2];

            minX = Math.min(minX, cx - r);
            maxX = Math.max(maxX, cx + r);
            minY = Math.min(minY, cy - r);
            maxY = Math.max(maxY, cy + r);
        }

        for (int x = minX; x <= maxX; x++) {
            for (int y = minY; y <= maxY; y++) {
                for (int[] circle : circles) {
                    int cx = circle[0];
                    int cy = circle[1];
                    int r = circle[2];

                    int dx = x - cx;
                    int dy = y - cy;
                    if (dx * dx + dy * dy <= r * r) {
                        latticePoints.add(x + "," + y);
                        break;
                    }
                }
            }
        }

        return latticePoints.size();
    }
}