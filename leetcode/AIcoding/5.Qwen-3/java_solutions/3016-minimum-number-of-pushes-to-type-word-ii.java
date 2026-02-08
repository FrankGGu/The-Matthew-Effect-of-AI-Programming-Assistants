public class Solution {

import java.util.*;

public class Solution {
    public int minimumPushes(String word) {
        Map<Character, Integer> freq = new HashMap<>();
        for (char c : word.toCharArray()) {
            freq.put(c, freq.getOrDefault(c, 0) + 1);
        }

        List<Map.Entry<Character, Integer>> entries = new ArrayList<>(freq.entrySet());
        entries.sort((a, b) -> b.getValue().compareTo(a.getValue()));

        int pushes = 0;
        int count = 0;

        for (Map.Entry<Character, Integer> entry : entries) {
            count++;
            if (count <= 8) {
                pushes += entry.getValue() * 1;
            } else if (count <= 16) {
                pushes += entry.getValue() * 2;
            } else if (count <= 24) {
                pushes += entry.getValue() * 3;
            } else {
                pushes += entry.getValue() * 4;
            }
        }

        return pushes;
    }
}
}