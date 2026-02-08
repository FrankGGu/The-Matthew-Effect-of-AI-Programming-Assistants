public class Solution {

import java.util.*;

public class Solution {
    public int[] transformArray(int n, int[][] queries) {
        int[] result = new int[queries.length];
        int[] arr = new int[n];

        for (int i = 0; i < queries.length; i++) {
            int index = queries[i][0];
            int val = queries[i][1];
            arr[index] = val;
            result[i] = Arrays.stream(arr).sum();
        }

        return result;
    }
}
}