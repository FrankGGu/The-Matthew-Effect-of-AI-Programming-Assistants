class Solution {
    public int largestOverlap(int[][] img1, int[][] img2) {
        int n = img1.length;
        int maxOverlap = 0;

        for (int xOffset = -n + 1; xOffset < n; xOffset++) {
            for (int yOffset = -n + 1; yOffset < n; yOffset++) {
                int overlap = 0;
                for (int i = 0; i < n; i++) {
                    for (int j = 0; j < n; j++) {
                        int shiftedRow = i + xOffset;
                        int shiftedCol = j + yOffset;

                        if (shiftedRow >= 0 && shiftedRow < n && shiftedCol >= 0 && shiftedCol < n) {
                            if (img1[i][j] == 1 && img2[shiftedRow][shiftedCol] == 1) {
                                overlap++;
                            }
                        }
                    }
                }
                maxOverlap = Math.max(maxOverlap, overlap);
            }
        }

        return maxOverlap;
    }
}