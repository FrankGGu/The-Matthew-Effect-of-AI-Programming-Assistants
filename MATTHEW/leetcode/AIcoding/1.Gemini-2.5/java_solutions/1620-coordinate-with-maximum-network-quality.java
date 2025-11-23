class Solution {
    public int[] coordinateWithMaxNetworkQuality(int[][] towers, int radius) {
        int maxQuality = 0;
        int bestX = 0;
        int bestY = 0;

        for (int x = 0; x <= 100; x++) {
            for (int y = 0; y <= 100; y++) {
                int currentQuality = 0;
                for (int[] tower : towers) {
                    int tx = tower[0];
                    int ty = tower[1];
                    int q = tower[2];

                    double distSq = Math.pow(x - tx, 2) + Math.pow(y - ty, 2);
                    double dist = Math.sqrt(distSq);

                    if (dist <= radius) {
                        currentQuality += (int) (q / (1 + dist));
                    }
                }

                if (currentQuality > maxQuality) {
                    maxQuality = currentQuality;
                    bestX = x;
                    bestY = y;
                } else if (currentQuality == maxQuality) {
                    if (x < bestX) {
                        bestX = x;
                        bestY = y;
                    } else if (x == bestX && y < bestY) {
                        bestY = y;
                    }
                }
            }
        }

        return new int[]{bestX, bestY};
    }
}