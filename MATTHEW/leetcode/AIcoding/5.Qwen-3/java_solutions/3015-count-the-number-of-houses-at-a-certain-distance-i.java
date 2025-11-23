public class Solution {

import java.util.*;

public class Solution {
    public int[] distanceHouses(int[][] delivery) {
        Map<Integer, Integer> distanceCount = new HashMap<>();
        for (int[] d : delivery) {
            int start = d[0];
            int end = d[1];
            int distance = d[2];
            for (int i = start; i <= end; i++) {
                distanceCount.put(i, distanceCount.getOrDefault(i, 0) + 1);
            }
        }
        int[] result = new int[distanceCount.size()];
        int index = 0;
        for (Map.Entry<Integer, Integer> entry : distanceCount.entrySet()) {
            result[index++] = entry.getValue();
        }
        Arrays.sort(result);
        return result;
    }
}
}