public class Solution {

import java.util.*;

public class Solution {
    public int countOfIntegers(int[] nums, int k) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }
        int result = 0;
        for (Map.Entry<Integer, Integer> entry : freq.entrySet()) {
            if (entry.getValue() >= k) {
                result++;
            }
        }
        return result;
    }
}
}