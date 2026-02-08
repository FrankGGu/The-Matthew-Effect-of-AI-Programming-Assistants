import java.util.Arrays;

class Solution {
    private long distSq(int[] p1, int[] p2) {
        return (long)(p1[0] - p2[0]) * (p1[0] - p2[0]) + 
               (long)(p1[1] - p2[1]) * (p1[1] - p2[1]);
    }

    public boolean validSquare(int[] p1, int[] p2, int[] p3, int[] p4) {
        long[] distances = new long[6];
        distances[0] = distSq(p1, p2);
        distances[1] = distSq(p1, p3);
        distances[2] = distSq(p1, p4);
        distances[3] = distSq(p2, p3);
        distances[4] = distSq(p2, p4);
        distances[5] = distSq(p3, p4);

        Arrays.sort(distances);

        return distances[0] > 0 && 
               distances[0] == distances[1] && 
               distances[0] == distances[2] && 
               distances[0] == distances[3] && 
               distances[4] == distances[5] && 
               distances[4] == 2 * distances[0];
    }
}