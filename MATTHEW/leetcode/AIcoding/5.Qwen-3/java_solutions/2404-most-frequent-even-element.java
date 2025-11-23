public class Solution {

import java.util.*;

public class Solution {
    public int mostFrequentEven(int[] nums) {
        Map<Integer, Integer> frequency = new HashMap<>();
        int maxFreq = 0;
        int result = Integer.MAX_VALUE;

        for (int num : nums) {
            if (num % 2 == 0) {
                frequency.put(num, frequency.getOrDefault(num, 0) + 1);
                int currentFreq = frequency.get(num);
                if (currentFreq > maxFreq || (currentFreq == maxFreq && num < result)) {
                    maxFreq = currentFreq;
                    result = num;
                }
            }
        }

        return result;
    }
}
}