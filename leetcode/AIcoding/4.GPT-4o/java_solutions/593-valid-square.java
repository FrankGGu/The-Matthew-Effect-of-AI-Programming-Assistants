import java.util.HashSet;

public class Solution {
    public boolean validSquare(int[] p1, int[] p2, int[] p3, int[] p4) {
        HashSet<Integer> distances = new HashSet<>();
        int[][] points = {p1, p2, p3, p4};

        for (int i = 0; i < 4; i++) {
            for (int j = i + 1; j < 4; j++) {
                int dist = getDistance(points[i], points[j]);
                if (dist > 0) {
                    distances.add(dist);
                }
            }
        }

        return distances.size() == 2;
    }

    private int getDistance(int[] p1, int[] p2) {
        return (p1[0] - p2[0]) * (p1[0] - p2[0]) + (p1[1] - p2[1]) * (p1[1] - p2[1]);
    }
}