public class Solution {

import java.util.*;

public class Solution {
    public int numOfPairs(String[] nums, String target) {
        Map<String, Integer> countMap = new HashMap<>();
        for (String num : nums) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }

        int result = 0;
        for (int i = 1; i < target.length(); i++) {
            String left = target.substring(0, i);
            String right = target.substring(i);
            if (countMap.containsKey(left) && countMap.containsKey(right)) {
                if (left.equals(right)) {
                    result += countMap.get(left);
                } else {
                    result += countMap.get(left) * countMap.get(right);
                }
            }
        }
        return result;
    }
}
}