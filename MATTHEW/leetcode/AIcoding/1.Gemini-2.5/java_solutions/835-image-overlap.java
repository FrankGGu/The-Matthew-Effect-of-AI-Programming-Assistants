class Solution {
    public int largestOverlap(int[][] img1, int[][] img2) {
        int n = img1.length;
        int maxOverlap = 0;

        // Iterate over all possible vertical shifts (ty) for img2
        // ty ranges from -(n-1) to (n-1)
        for (int ty = -(n - 1); ty < n; ty++) {
            // Iterate over all possible horizontal shifts (tx) for img2
            // tx ranges from -(n-1) to (n-1)
            for (int tx = -(n - 1); tx < n; tx++) {
                int currentOverlap = 0;
                // Calculate overlap for the current (ty, tx) shift
                // Iterate through img1's cells (r1, c1)
                for (int r1 = 0; r1 < n; r1++) {
                    for (int c1 = 0; c1 < n; c1++) {
                        // If img1[r1][c1] is 1, check corresponding cell in img2
                        if (img1[r1][c1] == 1) {
                            // Calculate corresponding coordinates in img2 *before* translation
                            // If img2 is shifted by (ty, tx), then img1[r1][c1] aligns with img2[r2][c2]
                            // where r1 = r2 + ty and c1 = c2 + tx
                            // So, r2 = r1 - ty and c2 = c1 - tx
                            int r2 = r1 - ty;
                            int c2 = c1 - tx;

                            // Check if (r2, c2) is within img2 bounds
                            if (r2 >= 0 && r2 < n && c2 >= 0 && c2 < n) {
                                if (img2[r2][c2] == 1) {
                                    currentOverlap++;
                                }
                            }
                        }
                    }
                }
                maxOverlap = Math.max(maxOverlap, currentOverlap);
            }
        }

        return maxOverlap;
    }
}