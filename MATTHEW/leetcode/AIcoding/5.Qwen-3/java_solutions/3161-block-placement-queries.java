public class Solution {

import java.util.*;

public class Solution {
    public int[] blockPlacementQueries(int n, int[][] queries) {
        List<Integer> sorted = new ArrayList<>();
        for (int i = 1; i <= n; i++) {
            sorted.add(i);
        }
        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int k = queries[i][0];
            int x = queries[i][1];
            int pos = Collections.binarySearch(sorted, x);
            if (pos >= 0) {
                sorted.remove(pos);
            } else {
                pos = -(pos + 1);
                sorted.add(pos, x);
            }
            result[i] = sorted.size();
        }
        return result;
    }
}
}