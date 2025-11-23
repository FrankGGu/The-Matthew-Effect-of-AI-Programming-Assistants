public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int countPairs(int[] nums, int k) {
        Map<Integer, Integer> freq = new HashMap<>();
        int result = 0;
        for (int num : nums) {
            int rem = num % k;
            int complement = (k - rem) % k;
            result += freq.getOrDefault(complement, 0);
            freq.put(rem, freq.getOrDefault(rem, 0) + 1);
        }
        return result;
    }
}
}