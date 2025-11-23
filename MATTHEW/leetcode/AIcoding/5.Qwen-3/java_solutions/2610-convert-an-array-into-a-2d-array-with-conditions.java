public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> find2DArray(int[] nums) {
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int num : nums) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }

        List<List<Integer>> result = new ArrayList<>();
        while (!countMap.isEmpty()) {
            List<Integer> row = new ArrayList<>();
            List<Integer> keysToRemove = new ArrayList<>();
            for (Map.Entry<Integer, Integer> entry : countMap.entrySet()) {
                row.add(entry.getKey());
                int newCount = entry.getValue() - 1;
                if (newCount == 0) {
                    keysToRemove.add(entry.getKey());
                } else {
                    countMap.put(entry.getKey(), newCount);
                }
            }
            result.add(row);
            for (int key : keysToRemove) {
                countMap.remove(key);
            }
        }
        return result;
    }
}
}