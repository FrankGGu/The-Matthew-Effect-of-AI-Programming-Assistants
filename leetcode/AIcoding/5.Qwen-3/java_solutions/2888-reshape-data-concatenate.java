public class Solution {

import java.util.Arrays;

public class Solution {
    public int[][] concatenateArrays(int[][] arr1, int[][] arr2) {
        int m = arr1.length;
        int n = arr1[0].length;
        int p = arr2.length;
        int q = arr2[0].length;

        int[][] result = new int[m + p][n];

        for (int i = 0; i < m; i++) {
            System.arraycopy(arr1[i], 0, result[i], 0, n);
        }

        for (int i = 0; i < p; i++) {
            System.arraycopy(arr2[i], 0, result[m + i], 0, q);
        }

        return result;
    }
}
}