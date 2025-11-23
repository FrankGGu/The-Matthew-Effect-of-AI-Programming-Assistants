public class Solution {

import java.util.*;

public class Solution {
    public int maxGroups(int[] batchSize) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int b : batchSize) {
            count.put(b, count.getOrDefault(b, 0) + 1);
        }

        int result = 0;
        while (true) {
            boolean hasGroup = false;
            for (int b : batchSize) {
                if (count.get(b) > 0) {
                    count.put(b, count.get(b) - 1);
                    hasGroup = true;
                    result++;
                    break;
                }
            }
            if (!hasGroup) break;
        }
        return result;
    }
}
}