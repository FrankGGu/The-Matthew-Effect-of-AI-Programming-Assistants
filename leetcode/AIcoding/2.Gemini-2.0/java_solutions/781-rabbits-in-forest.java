import java.util.HashMap;
import java.util.Map;

class Solution {
    public int numRabbits(int[] answers) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int answer : answers) {
            count.put(answer, count.getOrDefault(answer, 0) + 1);
        }
        int result = 0;
        for (Map.Entry<Integer, Integer> entry : count.entrySet()) {
            int key = entry.getKey();
            int value = entry.getValue();
            int groupSize = key + 1;
            int numGroups = (value + groupSize - 1) / groupSize;
            result += numGroups * groupSize;
        }
        return result;
    }
}