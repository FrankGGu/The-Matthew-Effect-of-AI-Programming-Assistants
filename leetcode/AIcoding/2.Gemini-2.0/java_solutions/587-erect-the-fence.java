import java.util.Arrays;
import java.util.List;
import java.util.ArrayList;

class Solution {
    public int[][] outerTrees(int[][] points) {
        if (points == null || points.length <= 1) {
            return points;
        }

        Arrays.sort(points, (a, b) -> {
            int cmp = Integer.compare(a[0], b[0]);
            if (cmp == 0) {
                cmp = Integer.compare(a[1], b[1]);
            }
            return cmp;
        });

        List<int[]> upper = new ArrayList<>();
        List<int[]> lower = new ArrayList<>();

        for (int i = 0; i < points.length; i++) {
            while (upper.size() >= 2 && crossProduct(upper.get(upper.size() - 2), upper.get(upper.size() - 1), points[i]) > 0) {
                upper.remove(upper.size() - 1);
            }
            upper.add(points[i]);
        }

        for (int i = points.length - 1; i >= 0; i--) {
            while (lower.size() >= 2 && crossProduct(lower.get(lower.size() - 2), lower.get(lower.size() - 1), points[i]) > 0) {
                lower.remove(lower.size() - 1);
            }
            lower.add(points[i]);
        }

        List<int[]> result = new ArrayList<>(upper);
        result.remove(result.size() - 1);
        result.addAll(lower);
        result.remove(result.size() - 1);

        int[][] res = new int[result.size()][2];
        for (int i = 0; i < result.size(); i++) {
            res[i] = result.get(i);
        }

        boolean[][] visited = new boolean[points.length][2];
        List<int[]> uniqueResult = new ArrayList<>();
        for (int[] point : res) {
            boolean found = false;
            for(int[] existingPoint : uniqueResult){
                if(point[0] == existingPoint[0] && point[1] == existingPoint[1]){
                    found = true;
                    break;
                }
            }
            if(!found){
                uniqueResult.add(point);
            }
        }

        int[][] finalResult = new int[uniqueResult.size()][2];
        for (int i = 0; i < uniqueResult.size(); i++) {
            finalResult[i] = uniqueResult.get(i);
        }

        return finalResult;
    }

    private int crossProduct(int[] a, int[] b, int[] c) {
        return (b[0] - a[0]) * (c[1] - a[1]) - (b[1] - a[1]) * (c[0] - a[0]);
    }
}