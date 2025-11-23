import java.util.HashMap;

public class Solution {
    public int mostFrequentEven(int[] nums) {
        HashMap<Integer, Integer> freqMap = new HashMap<>();
        int maxFreq = 0;
        int result = -1;

        for (int num : nums) {
            if (num % 2 == 0) {
                freqMap.put(num, freqMap.getOrDefault(num, 0) + 1);
                int currentFreq = freqMap.get(num);
                if (currentFreq > maxFreq || (currentFreq == maxFreq && num > result)) {
                    maxFreq = currentFreq;
                    result = num;
                }
            }
        }

        return result;
    }
}