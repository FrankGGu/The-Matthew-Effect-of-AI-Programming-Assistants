import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.HashSet;

class Solution {
    public int[][] outerTrees(int[][] trees) {
        if (trees.length <= 3) {
            Set<List<Integer>> uniquePointsSet = new HashSet<>();
            for (int[] tree : trees) {
                uniquePointsSet.add(Arrays.asList(tree[0], tree[1]));
            }
            int[][] result = new int[uniquePointsSet.size()][2];
            int i = 0;
            for (List<Integer> p : uniquePointsSet) {
                result[i++] = new int[]{p.get(0), p.get(1)};
            }
            return result;
        }

        Arrays.sort(trees, (p1, p2) -> {
            if (p1[0] != p2[0]) {
                return p1[0] - p2[0];
            }
            return p1[1] - p2[1];
        });

        List<int[]> hull = new ArrayList<>();

        for (int[] p : trees) {
            while (hull.size() >= 2 && crossProduct(hull.get(hull.size() - 2), hull.get(hull.size() - 1), p) < 0) {
                hull.remove(hull.size() - 1);
            }
            hull.add(p);
        }

        for (int i = trees.length - 2; i >= 0; i--) {
            int[] p = trees[i];
            while (hull.size() >= 2 && crossProduct(hull.get(hull.size() - 2), hull.get(hull.size() - 1), p) > 0) {
                hull.remove(hull.size() - 1);
            }
            hull.add(p);
        }

        Set<List<Integer>> resultPoints = new HashSet<>();
        for (int[] p : hull) {
            resultPoints.add(Arrays.asList(p[0], p[1]));
        }

        int[][] result = new int[resultPoints.size()][2];
        int i = 0;
        for (List<Integer> p : resultPoints) {
            result[i++] = new int[]{p.get(0), p.get(1)};
        }

        return result;
    }

    private long crossProduct(int[] p1, int[] p2, int[] p3) {
        return (long)(p2[0] - p1[0]) * (p3[1] - p1[1]) - (long)(p2[1] - p1[1]) * (p3[0] - p1[0]);
    }
}