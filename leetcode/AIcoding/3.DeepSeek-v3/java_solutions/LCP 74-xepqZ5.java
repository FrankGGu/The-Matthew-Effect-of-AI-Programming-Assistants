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

        int maxQuality = 0;
        int[] result = new int[]{0, 0};

        for (int x = minX; x <= maxX; x++) {
            for (int y = minY; y <= maxY; y++) {
                int quality = 0;
                for (int[] tower : towers) {
                    int tx = tower[0], ty = tower[1], tq = tower[2];
                    double distance = Math.sqrt((x - tx) * (x - tx) + (y - ty) * (y - ty));
                    if (distance <= radius) {
                        quality += (int)(tq / (1 + distance));
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