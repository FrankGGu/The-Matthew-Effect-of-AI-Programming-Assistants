import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int findTheKey(int[] numbers) {
        Map<Integer, Integer> frequencyMap = new HashMap<>();
        for (int num : numbers) {
            frequencyMap.put(num, frequencyMap.getOrDefault(num, 0) + 1);
        }

        int maxFrequency = 0;
        int key = -1;
        for (Map.Entry<Integer, Integer> entry : frequencyMap.entrySet()) {
            int num = entry.getKey();
            int frequency = entry.getValue();
            if (frequency > maxFrequency) {
                maxFrequency = frequency;
                key = num;
            } else if (frequency == maxFrequency && num < key) {
                key = num;
            }
        }

        return key;
    }
}