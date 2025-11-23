public class Solution {

import java.util.*;

public class Solution {
    public int countPairs(int[] nums, int k) {
        Map<Integer, Integer> freq = new HashMap<>();
        int count = 0;
        for (int num : nums) {
            int key = num % k;
            count += freq.getOrDefault(key, 0);
            freq.put(num % k, freq.getOrDefault(num % k, 0) + 1);
        }
        return count;
    }
}
}