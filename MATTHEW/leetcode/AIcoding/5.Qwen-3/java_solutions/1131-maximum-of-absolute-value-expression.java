public class Solution {

import java.util.*;

public class Solution {
    public int maxAbsValExpr(int[] arr1, int[] arr2) {
        int n = arr1.length;
        int max = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int val = Math.abs(arr1[i] - arr1[j]) + Math.abs(arr2[i] - arr2[j]);
                if (val > max) {
                    max = val;
                }
            }
        }
        return max;
    }
}
}