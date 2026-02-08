public class Solution {

import java.util.*;

public class Solution {
    public int numIdenticalPairs(int[] nums) {
        Map<Integer, Integer> countMap = new HashMap<>();
        int result = 0;
        for (int num : nums) {
            int count = countMap.getOrDefault(num, 0);
            result += count;
            countMap.put(num, count + 1);
        }
        return result;
    }
}
}