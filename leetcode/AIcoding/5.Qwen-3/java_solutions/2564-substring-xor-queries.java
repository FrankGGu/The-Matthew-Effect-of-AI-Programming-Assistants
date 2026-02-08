public class Solution {

import java.util.*;

public class Solution {
    public int[] substringXOR(int[] nums, int[][] queries) {
        int n = nums.length;
        int m = queries.length;
        int[] result = new int[m];

        Map<Integer, List<Integer>> prefixMap = new HashMap<>();
        int prefix = 0;
        prefixMap.put(0, new ArrayList<>());
        prefixMap.get(0).add(-1);

        for (int i = 0; i < n; i++) {
            prefix ^= nums[i];
            if (!prefixMap.containsKey(prefix)) {
                prefixMap.put(prefix, new ArrayList<>());
            }
            prefixMap.get(prefix).add(i);
        }

        for (int i = 0; i < m; i++) {
            int x = queries[i][0];
            int y = queries[i][1];
            int target = x ^ y;
            List<Integer> indices = prefixMap.get(target);
            if (indices == null || indices.isEmpty()) {
                result[i] = -1;
                continue;
            }
            int minLen = Integer.MAX_VALUE;
            int bestStart = -1;
            int bestEnd = -1;
            for (int idx : indices) {
                int start = idx + 1;
                int end = i;
                int len = end - start + 1;
                if (len < minLen) {
                    minLen = len;
                    bestStart = start;
                    bestEnd = end;
                }
            }
            if (bestStart != -1 && bestEnd != -1) {
                result[i] = bestStart;
            } else {
                result[i] = -1;
            }
        }

        return result;
    }
}
}