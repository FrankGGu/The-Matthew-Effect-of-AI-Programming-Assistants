import java.util.*;

public class Solution {
    public int[][] outerTrees(int[][] trees) {
        if (trees.length <= 1) return trees;
        Arrays.sort(trees, (a, b) -> a[0] == b[0] ? a[1] - b[1] : a[0] - b[0]);

        Set<int[]> hull = new HashSet<>();

        // Build lower hull 
        for (int[] tree : trees) {
            while (hull.size() >= 2) {
                int[] a = (int[]) hull.toArray()[hull.size() - 1];
                int[] b = (int[]) hull.toArray()[hull.size() - 2];
                if (cross(b, a, tree) > 0) break;
                hull.remove(a);
            }
            hull.add(tree);
        }

        // Build upper hull
        int lowerSize = hull.size();
        for (int i = trees.length - 1; i >= 0; i--) {
            int[] tree = trees[i];
            while (hull.size() > lowerSize) {
                int[] a = (int[]) hull.toArray()[hull.size() - 1];
                int[] b = (int[]) hull.toArray()[hull.size() - 2];
                if (cross(b, a, tree) > 0) break;
                hull.remove(a);
            }
            hull.add(tree);
        }

        return hull.toArray(new int[hull.size()][]);
    }

    private int cross(int[] o, int[] a, int[] b) {
        return (a[0] - o[0]) * (b[1] - o[1]) - (a[1] - o[1]) * (b[0] - o[0]);
    }
}