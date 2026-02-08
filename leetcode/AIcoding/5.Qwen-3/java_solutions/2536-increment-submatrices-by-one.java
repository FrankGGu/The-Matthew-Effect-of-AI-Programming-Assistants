public class Solution {

import java.util.*;

public class Solution {
    public int[][] rangeAddQueries(int n, int[][] queries) {
        int[][] res = new int[n][n];
        for (int[] q : queries) {
            int l = q[0], r = q[1], c = q[2];
            for (int i = l; i <= r; i++) {
                res[i][c]++;
            }
        }
        return res;
    }
}
}