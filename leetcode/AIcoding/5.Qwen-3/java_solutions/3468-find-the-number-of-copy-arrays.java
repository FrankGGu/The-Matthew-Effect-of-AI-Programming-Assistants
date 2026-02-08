public class Solution {

import java.util.*;

public class Solution {
    public int numberOfCopyArrays(int[] nums) {
        int n = nums.length;
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int num : nums) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }
        int result = 1;
        for (int count : countMap.values()) {
            result *= count;
        }
        return result;
    }
}
}