import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    public int[][] outerTrees(int[][] points) {
        if (points.length <= 2) {
            return points;
        }

        Arrays.sort(points, (a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0];
            }
            return a[1] - b[1];
        });

        List<int[]> hull = new ArrayList<>();

        // Build lower hull
        for (int[] p : points) {
            while (hull.size() >= 2 && crossProduct(hull.get(hull.size() - 2), hull.get(hull.size() - 1), p) < 0) {
                hull.remove(hull.size() - 1);
            }
            hull.add(p);
        }

        // Build upper hull
        int t = hull.size();
        for (int i = points.length - 2; i >= 0; i--) {
            int[] p = points[i];
            while (hull.size() > t && crossProduct(hull.get(hull.size() - 2), hull.get(hull.size() - 1), p) < 0) {
                hull.remove(hull.size() - 1);
            }
            hull.add(p);
        }

        Set<List<Integer>> uniquePoints = new HashSet<>();
        for (int[] p : hull) {
            uniquePoints.add(Arrays.asList(p[0], p[1]));
        }

        int[][] result = new int[uniquePoints.size()][2];
        int i = 0;
        for (List<Integer> p : uniquePoints) {
            result[i][0] = p.get(0);
            result[i][1] = p.get(1);
            i++;
        }

        return result;
    }

    private int crossProduct(int[] p1, int[] p2, int[] p3) {
        return (p2[0] - p1[0]) * (p3[1] - p1[1]) - (p2[1] - p1[1]) * (p3[0] - p1[0]);
    }
}