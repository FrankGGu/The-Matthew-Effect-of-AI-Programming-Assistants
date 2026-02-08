public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(String s) {
        Map<Character, Integer> freq = new HashMap<>();
        for (char c : s.toCharArray()) {
            freq.put(c, freq.getOrDefault(c, 0) + 1);
        }

        List<Integer> counts = new ArrayList<>(freq.values());
        Collections.sort(counts);

        int operations = 0;
        int target = counts.get(counts.size() - 1);

        for (int i = counts.size() - 2; i >= 0; i--) {
            if (counts.get(i) == target) continue;
            if (counts.get(i) < target) {
                return -1;
            }
            operations += counts.get(i) - target;
            target = counts.get(i) - (counts.get(i) - target);
        }

        return operations;
    }
}
}