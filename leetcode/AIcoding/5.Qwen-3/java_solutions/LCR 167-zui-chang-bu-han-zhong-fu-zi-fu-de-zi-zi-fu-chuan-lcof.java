public class Solution {

import java.util.*;

public class Solution {
    public int[] dissectMove(int[] moves) {
        Map<Character, Integer> count = new HashMap<>();
        for (char c : moves) {
            count.put(c, count.getOrDefault(c, 0) + 1);
        }
        List<Character> sortedChars = new ArrayList<>(count.keySet());
        Collections.sort(sortedChars);
        int[] result = new int[sortedChars.size()];
        for (int i = 0; i < sortedChars.size(); i++) {
            result[i] = count.get(sortedChars.get(i));
        }
        return result;
    }
}
}