public class Solution {

import java.util.*;

public class Solution {
    public int[] leftmostBuildingQueries(int[] a, int[] b) {
        int n = a.length;
        int m = b.length;
        int[] result = new int[n];
        Arrays.fill(result, -1);

        Map<Integer, List<Integer>> aIndexMap = new HashMap<>();
        for (int i = 0; i < n; i++) {
            aIndexMap.putIfAbsent(a[i], new ArrayList<>());
            aIndexMap.get(a[i]).add(i);
        }

        for (int i = 0; i < n; i++) {
            int aVal = a[i];
            if (aVal > m) continue;
            List<Integer> bIndices = aIndexMap.getOrDefault(aVal, new ArrayList<>());
            for (int j : bIndices) {
                if (j > i) {
                    result[i] = j;
                    break;
                }
            }
        }

        return result;
    }
}
}