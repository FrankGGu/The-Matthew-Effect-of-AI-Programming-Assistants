public class Solution {

import java.util.*;

public class Solution {
    public int[] distributeElements(int[] nums) {
        int[] result = new int[2];
        Map<Integer, Integer> countMap = new HashMap<>();

        for (int num : nums) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }

        for (Map.Entry<Integer, Integer> entry : countMap.entrySet()) {
            int value = entry.getValue();
            if (value % 2 == 0) {
                result[0] += value / 2;
                result[1] += value / 2;
            } else {
                result[0] += value / 2 + 1;
                result[1] += value / 2;
            }
        }

        return result;
    }
}
}