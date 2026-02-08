class Solution {
    public int[] bestCoordinate(int[][] towers, int radius) {
        int maxX = 0, maxY = 0;
        for (int[] tower : towers) {
            maxX = Math.max(maxX, tower[0]);
            maxY = Math.max(maxY, tower[1]);
        }

        int bestX = 0, bestY = 0, maxQuality = 0;

        for (int x = 0; x <= maxX; x++) {
            for (int y = 0; y <= maxY; y++) {
                int quality = 0;
                for (int[] tower : towers) {
                    double distance = Math.sqrt(Math.pow(x - tower[0], 2) + Math.pow(y - tower[1], 2));
                    if (distance <= radius) {
                        quality += (int) (tower[2] / (1 + distance));
                    }
                }

                if (quality > maxQuality) {
                    maxQuality = quality;
                    bestX = x;
                    bestY = y;
                } else if (quality == maxQuality && (x < bestX || (x == bestX && y < bestY))) {
                    bestX = x;
                    bestY = y;
                }
            }
        }

        return new int[]{bestX, bestY};
    }
}