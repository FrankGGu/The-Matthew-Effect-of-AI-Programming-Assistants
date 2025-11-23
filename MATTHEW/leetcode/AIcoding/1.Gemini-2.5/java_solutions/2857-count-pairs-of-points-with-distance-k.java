import java.util.HashMap;
import java.util.Map;

class Solution {
    public long countPairs(int[][] points, int k) {
        // Max coordinates are 1000. So we can use a 2D array for frequencies.
        // x and y are in [0, 1000].
        int[][] freq = new int[1001][1001];
        int totalPoints = points.length;

        // Populate the frequency array
        for (int[] p : points) {
            freq[p[0]][p[1]]++;
        }

        long totalPairs = 0;

        // Iterate through all possible x1, y1 coordinates
        for (int x1 = 0; x1 <= 1000; x1++) {
            for (int y1 = 0; y1 <= 1000; y1++) {
                // If there are no points at (x1, y1), skip
                if (freq[x1][y1] == 0) {
                    continue;
                }

                int count1 = freq[x1][y1];

                // Iterate through all possible dx values from 0 to k
                // dy will be k - dx
                for (int dx = 0; dx <= k; dx++) {
                    int dy = k - dx;

                    // Calculate the four potential target points (x2, y2)
                    // (x1 - dx, y1 - dy)
                    // (x1 - dx, y1 + dy)
                    // (x1 + dx, y1 - dy)
                    // (x1 + dx, y1 + dy)

                    // To avoid redundant calculations and handle cases where dx=0 or dy=0:
                    // dx_options will contain {dx} if dx=0, or {dx, -dx} if dx!=0
                    int[] dx_options = {dx};
                    if (dx != 0) {
                        dx_options = new int[]{dx, -dx};
                    }

                    // dy_options will contain {dy} if dy=0, or {dy, -dy} if dy!=0
                    int[] dy_options = {dy};
                    if (dy != 0) {
                        dy_options = new int[]{dy, -dy};
                    }

                    for (int current_dx : dx_options) {
                        for (int current_dy : dy_options) {
                            int x2 = x1 + current_dx;
                            int y2 = y1 + current_dy;

                            // Check if (x2, y2) is within the valid coordinate range [0, 1000]
                            if (x2 >= 0 && x2 <= 1000 && y2 >= 0 && y2 <= 1000) {
                                // If there are points at (x2, y2)
                                if (freq[x2][y2] > 0) {
                                    int count2 = freq[x2][y2];
                                    // Add count1 * count2 to totalPairs.
                                    // This counts ordered pairs (P_A, P_B) where P_A is one of the count1 points at (x1,y1)
                                    // and P_B is one of the count2 points at (x2,y2).
                                    totalPairs += (long) count1 * count2;
                                }
                            }
                        }
                    }
                }
            }
        }

        // The problem asks for pairs (pi, pj). Typically this means i != j.
        // If k=0, and (x1,y1) == (x2,y2), totalPairs includes count1 * count1.
        // This count1 * count1 includes 'count1' pairs of type (P_i, P_i).
        // Since P_i and P_j must be distinct points (i!=j), these 'count1' self-pairs must be excluded.
        // The total number of such self-pairs over all unique coordinates is 'totalPoints'.
        // So, if k=0, subtract 'totalPoints' from 'totalPairs'.
        if (k == 0) {
            totalPairs -= totalPoints;
        }

        // Each valid pair (P_A, P_B) has been counted twice:
        // once when P_A's coordinates were (x1,y1) and P_B's were (x2,y2),
        // and once when P_B's coordinates were (x1,y1) and P_A's were (x2,y2).
        // Divide by 2 to get the count of unique unordered pairs.
        return totalPairs / 2;
    }
}