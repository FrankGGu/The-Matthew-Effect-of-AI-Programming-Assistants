import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minimumRounds(int[] tasks) {
        Map<Integer, Integer> freqMap = new HashMap<>();
        for (int task : tasks) {
            freqMap.put(task, freqMap.getOrDefault(task, 0) + 1);
        }

        int totalRounds = 0;
        for (int count : freqMap.values()) {
            if (count == 1) {
                return -1;
            }
            // For any count >= 2, we can complete it.
            // We want to use as many 3-task rounds as possible.
            // If count % 3 == 0, rounds = count / 3
            // If count % 3 == 1, rounds = (count - 4) / 3 + 2 = (count / 3 - 1) + 2 = count / 3 + 1 (e.g., 4 -> 2+2, 7 -> 3+2+2)
            // If count % 3 == 2, rounds = count / 3 + 1 (e.g., 2 -> 2, 5 -> 3+2)
            // This can be simplified to (count + 2) / 3 using integer division.
            totalRounds += (count + 2) / 3;
        }

        return totalRounds;
    }
}