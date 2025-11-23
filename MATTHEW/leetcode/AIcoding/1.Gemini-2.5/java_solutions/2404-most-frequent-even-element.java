import java.util.HashMap;
import java.util.Map;

class Solution {
    public int mostFrequentEven(int[] nums) {
        Map<Integer, Integer> freqMap = new HashMap<>();
        for (int num : nums) {
            if (num % 2 == 0) {
                freqMap.put(num, freqMap.getOrDefault(num, 0) + 1);
            }
        }

        int maxFrequency = 0;
        int result = -1;

        for (Map.Entry<Integer, Integer> entry : freqMap.entrySet()) {
            int currentNum = entry.getKey();
            int currentFreq = entry.getValue();

            if (currentFreq > maxFrequency) {
                maxFrequency = currentFreq;
                result = currentNum;
            } else if (currentFreq == maxFrequency) {
                if (currentNum < result) {
                    result = currentNum;
                }
            }
        }

        return result;
    }
}