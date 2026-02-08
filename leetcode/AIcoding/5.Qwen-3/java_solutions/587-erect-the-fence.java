public class Solution {

import java.util.*;

public class Solution {
    public int[][] outerTrees(int[][] points) {
        if (points.length <= 1) return points;

        Arrays.sort(points, (a, b) -> {
            if (a[0] != b[0]) return a[0] - b[0];
            return a[1] - b[1];
        });

        List<int[]> upper = new ArrayList<>();
        List<int[]> lower = new ArrayList<>();

        for (int[] p : points) {
            while (lower.size() >= 2 && cross(lower.get(lower.size() - 2), lower.get(lower.size() - 1), p) < 0) {
                lower.remove(lower.size() - 1);
            }
            lower.add(p);
        }

        for (int[] p : points) {
            while (upper.size() >= 2 && cross(upper.get(upper.size() - 2), upper.get(upper.size() - 1), p) > 0) {
                upper.remove(upper.size() - 1);
            }
            upper.add(p);
        }

        Set<String> set = new HashSet<>();
        for (int[] p : lower) {
            set.add(p[0] + "," + p[1]);
        }
        for (int[] p : upper) {
            set.add(p[0] + "," + p[1]);
        }

        int[][] result = new int[set.size()][2];
        int i = 0;
        for (String s : set) {
            String[] parts = s.split(",");
            result[i][0] = Integer.parseInt(parts[0]);
            result[i][1] = Integer.parseInt(parts[1]);
            i++;
        }

        return result;
    }

    private int cross(int[] o, int[] a, int[] b) {
        return (a[0] - o[0]) * (b[1] - o[1]) - (a[1] - o[1]) * (b[0] - o[0]);
    }
}
}