public class Solution {

import java.util.*;

public class Solution {
    public int longestHarmoniousSubsequence(int[] nums) {
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int num : nums) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }

        int maxLength = 0;
        for (int key : countMap.keySet()) {
            if (countMap.containsKey(key + 1)) {
                maxLength = Math.max(maxLength, countMap.get(key) + countMap.get(key + 1));
            }
        }

        return maxLength;
    }
}
}