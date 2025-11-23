public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int countKDifference(int[] nums, int k) {
        int count = 0;
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            count += freq.getOrDefault(num - k, 0);
            count += freq.getOrDefault(num + k, 0);
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }
        return count;
    }
}
}