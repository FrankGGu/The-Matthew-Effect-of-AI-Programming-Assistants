import java.util.ArrayList;
import java.util.Collections;
import java.util.TreeSet;
import java.lang.Math;

class Solution {
    public int[] maxPointsInsideTheSquare(int[][] points, int[] queries) {
        TreeSet<Integer> radiiSet = new TreeSet<>();
        for (int[] point : points) {
            int r = Math.max(Math.abs(point[0]), Math.abs(point[1]));
            radiiSet.add(r);
        }

        ArrayList<Integer> distinctRadii = new ArrayList<>(radiiSet);

        int[] ans = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int queryValue = queries[i];

            int index = Collections.binarySearch(distinctRadii, queryValue);

            int count;
            if (index >= 0) {
                count = index + 1;
            } else {
                count = -index - 1;
            }
            ans[i] = count;
        }

        return ans;
    }
}