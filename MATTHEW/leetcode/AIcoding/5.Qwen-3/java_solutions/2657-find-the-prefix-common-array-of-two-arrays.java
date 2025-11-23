public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> commonPrefixes(int[] A, int[] B) {
        int n = A.length;
        List<Integer> result = new ArrayList<>();
        int[] count = new int[n + 1];
        int common = 0;

        for (int i = 0; i < n; i++) {
            count[A[i]]++;
            count[B[i]]++;
            if (count[A[i]] == 2) common++;
            if (count[B[i]] == 2) common++;
            result.add(common);
        }

        return result;
    }
}
}