public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> xorQueries(int[] arr, int[][] queries) {
        List<Integer> result = new ArrayList<>();
        int n = arr.length;
        int[] prefixXOR = new int[n + 1];

        for (int i = 0; i < n; i++) {
            prefixXOR[i + 1] = prefixXOR[i] ^ arr[i];
        }

        for (int[] q : queries) {
            int l = q[0];
            int r = q[1];
            result.add(prefixXOR[r + 1] ^ prefixXOR[l]);
        }

        return result;
    }
}
}