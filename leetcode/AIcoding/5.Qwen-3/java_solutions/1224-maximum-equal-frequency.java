public class Solution {

import java.util.*;

public class Solution {
    public int maxEqualFreq(int[] nums) {
        Map<Integer, Integer> count = new HashMap<>();
        Map<Integer, Integer> freq = new HashMap<>();
        int maxFreq = 0;
        int result = 0;

        for (int i = 0; i < nums.length; i++) {
            int num = nums[i];
            int c = count.getOrDefault(num, 0);
            if (c > 0) {
                freq.put(c, freq.get(c) - 1);
                if (freq.get(c) == 0) {
                    freq.remove(c);
                }
            }
            count.put(num, c + 1);
            freq.put(c + 1, freq.getOrDefault(c + 1, 0) + 1);
            maxFreq = Math.max(maxFreq, c + 1);

            if (freq.size() == 1) {
                if (maxFreq == 1 || freq.get(maxFreq) == 1) {
                    result = i + 1;
                }
            } else if (freq.size() == 2) {
                if (maxFreq == 1 && freq.get(1) == nums.length) {
                    result = i + 1;
                } else if (freq.containsKey(maxFreq) && freq.get(maxFreq) == 1) {
                    result = i + 1;
                } else if (freq.containsKey(maxFreq - 1) && freq.get(maxFreq - 1) == 1) {
                    result = i + 1;
                }
            }
        }

        return result;
    }
}
}