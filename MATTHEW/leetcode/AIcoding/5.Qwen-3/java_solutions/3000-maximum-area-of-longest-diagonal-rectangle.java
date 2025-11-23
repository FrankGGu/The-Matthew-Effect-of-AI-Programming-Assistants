public class Solution {

import java.util.*;

public class Solution {
    public int areaOfMaxDiagonal(int[][] A) {
        int max = 0;
        for (int[] a : A) {
            int x = a[0], y = a[1];
            int diag = x * x + y * y;
            if (diag > max) {
                max = diag;
            }
        }
        int result = 0;
        for (int[] a : A) {
            int x = a[0], y = a[1];
            int diag = x * x + y * y;
            if (diag == max) {
                result = Math.max(result, x * y);
            }
        }
        return result;
    }
}
}