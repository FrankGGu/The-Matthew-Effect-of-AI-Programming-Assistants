public class Solution {

import java.util.*;

public class Solution {
    public int maxFrequency(int[] nums) {
        Map<Integer, Integer> freqMap = new HashMap<>();
        for (int num : nums) {
            freqMap.put(num, freqMap.getOrDefault(num, 0) + 1);
        }

        int maxFreq = 0;
        for (int freq : freqMap.values()) {
            if (freq > maxFreq) {
                maxFreq = freq;
            }
        }

        int count = 0;
        for (int freq : freqMap.values()) {
            if (freq == maxFreq) {
                count++;
            }
        }

        return count;
    }
}
}