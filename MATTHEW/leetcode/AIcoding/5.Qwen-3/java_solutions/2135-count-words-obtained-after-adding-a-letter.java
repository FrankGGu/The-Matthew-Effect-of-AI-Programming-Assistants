public class Solution {

import java.util.*;

public class Solution {
    public int uniqueCount(List<String> words, List<String> puzzles) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (String word : words) {
            int mask = 0;
            for (char c : word.toCharArray()) {
                mask |= 1 << (c - 'a');
            }
            if (Integer.bitCount(mask) <= 7) {
                freq.put(mask, freq.getOrDefault(mask, 0) + 1);
            }
        }

        int result = 0;
        for (String puzzle : puzzles) {
            int pMask = 0;
            for (char c : puzzle.toCharArray()) {
                pMask |= 1 << (c - 'a');
            }
            int first = 1 << (puzzle.charAt(0) - 'a');
            int temp = pMask;
            while (true) {
                int sub = temp & (-temp);
                temp -= sub;
                if ((sub & first) != 0) {
                    result += freq.getOrDefault(temp, 0);
                }
                if (temp == 0) break;
            }
        }
        return result;
    }
}
}