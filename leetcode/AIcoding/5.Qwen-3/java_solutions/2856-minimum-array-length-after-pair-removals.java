public class Solution {

import java.util.*;

public class Solution {
    public int minLengthAfterRemovals(int[] nums) {
        int n = nums.length;
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        int maxFreq = 0;
        for (int count : freq.values()) {
            maxFreq = Math.max(maxFreq, count);
        }

        if (maxFreq > n / 2) {
            return 2 * maxFreq - n;
        } else {
            return n % 2;
        }
    }
}
}