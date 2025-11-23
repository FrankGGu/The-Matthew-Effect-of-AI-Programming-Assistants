public class Solution {

import java.util.*;

public class Solution {
    public int[] avoidFlood(int[] rains) {
        int n = rains.length;
        int[] result = new int[n];
        Arrays.fill(result, 1);
        TreeMap<Integer, Integer> lakeToIndex = new TreeMap<>();
        Map<Integer, Integer> lakeLastIndex = new Map<>();

        for (int i = 0; i < n; i++) {
            int lake = rains[i];
            if (lake == 0) {
                continue;
            }
            if (lakeLastIndex.containsKey(lake)) {
                Integer prevIndex = lakeLastIndex.get(lake);
                Integer nextIndex = lakeToIndex.ceilingKey(prevIndex + 1);
                if (nextIndex == null) {
                    return new int[0];
                }
                result[nextIndex] = lake;
                lakeToIndex.remove(nextIndex);
            }
            lakeLastIndex.put(lake, i);
            lakeToIndex.put(i, lake);
        }

        for (int i = 0; i < n; i++) {
            if (rains[i] == 0 && result[i] == 1) {
                result[i] = 5; // any value except 0
            }
        }

        return result;
    }
}
}