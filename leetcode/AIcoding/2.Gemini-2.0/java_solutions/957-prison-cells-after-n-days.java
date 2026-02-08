import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int[] prisonAfterNDays(int[] cells, int n) {
        Map<String, Integer> seen = new HashMap<>();
        int[] current = cells;
        int days = 0;
        boolean fastForward = false;

        while (days < n) {
            String key = Arrays.toString(current);
            if (seen.containsKey(key)) {
                int loopStart = seen.get(key);
                int loopLength = days - loopStart;
                int remainingDays = (n - days) % loopLength;
                for (int i = 0; i < remainingDays; i++) {
                    int[] next = new int[current.length];
                    for (int j = 1; j < current.length - 1; j++) {
                        next[j] = (current[j - 1] == current[j + 1]) ? 1 : 0;
                    }
                    current = next;
                }
                return current;
            } else {
                seen.put(key, days);
                int[] next = new int[current.length];
                for (int j = 1; j < current.length - 1; j++) {
                    next[j] = (current[j - 1] == current[j + 1]) ? 1 : 0;
                }
                current = next;
                days++;
            }
        }
        return current;
    }
}