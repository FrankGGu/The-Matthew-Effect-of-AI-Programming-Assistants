import java.util.HashMap;
import java.util.Map;

class Solution {
    public int colorClashMatching(int[] colors, int target) {
        Map<Integer, Integer> freqMap = new HashMap<>();
        int count = 0;

        for (int color : colors) {
            int complement = target - color;
            if (freqMap.containsKey(complement)) {
                count += freqMap.get(complement);
            }
            freqMap.put(color, freqMap.getOrDefault(color, 0) + 1);
        }
        return count;
    }
}