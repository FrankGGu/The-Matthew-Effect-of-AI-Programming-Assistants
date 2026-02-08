class Solution {
    public int[] bestCoordinate(int[][] towers, int radius) {
        int minX = Integer.MAX_VALUE, minY = Integer.MAX_VALUE;
        int maxX = Integer.MIN_VALUE, maxY = Integer.MIN_VALUE;
        for (int[] tower : towers) {
            int x = tower[0], y = tower[1];
            minX = Math.min(minX, x);
            minY = Math.min(minY, y);
            maxX = Math.max(maxX, x);
            maxY = Math.max(maxY, y);
        }

        int[] result = new int[2];
        double maxQuality = 0;

        for (int x = minX; x <= maxX; x++) {
            for (int y = minY; y <= maxY; y++) {
                double quality = 0;
                for (int[] tower : towers) {
                    int tx = tower[0], ty = tower[1];
                    double d = Math.sqrt((x - tx) * (x - tx) + (y - ty) * (y - ty));
                    if (d <= radius) {
                        quality += Math.floor(tower[2] / (1 + d));
                    }
                }
                if (quality > maxQuality) {
                    maxQuality = quality;
                    result[0] = x;
                    result[1] = y;
                } else if (quality == maxQuality) {
                    if (x < result[0] || (x == result[0] && y < result[1])) {
                        result[0] = x;
                        result[1] = y;
                    }
                }
            }
        }

        return result;
    }
}