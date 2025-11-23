import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> mostVisited(int n, int[] rounds) {
        int[] counts = new int[n + 1];

        for (int i = 0; i < rounds.length - 1; i++) {
            int start = rounds[i];
            int end = rounds[i + 1];

            int current = start;
            while (true) {
                counts[current]++;
                if (current == end) {
                    break;
                }
                current++;
                if (current > n) {
                    current = 1; 
                }
            }
        }

        int maxCount = 0;
        for (int i = 1; i <= n; i++) {
            if (counts[i] > maxCount) {
                maxCount = counts[i];
            }
        }

        List<Integer> result = new ArrayList<>();
        for (int i = 1; i <= n; i++) {
            if (counts[i] == maxCount) {
                result.add(i);
            }
        }

        return result;
    }
}