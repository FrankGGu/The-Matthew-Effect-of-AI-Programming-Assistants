public class Solution {

import java.util.*;

public class Solution {
    public int countPairs(List<Integer> nums, int k) {
        Map<String, Integer> countMap = new HashMap<>();
        int result = 0;

        for (int i = 0; i < nums.size(); i++) {
            int num = nums.get(i);
            String key = String.valueOf(num);
            result += countMap.getOrDefault(key, 0);
            countMap.put(key, countMap.getOrDefault(key, 0) + 1);
        }

        return result;
    }
}
}