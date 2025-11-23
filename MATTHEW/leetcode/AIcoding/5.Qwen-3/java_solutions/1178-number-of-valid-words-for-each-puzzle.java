public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> findNumOfValidWords(String[] words, String puzzles) {
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

        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < puzzles.length(); i++) {
            char p = puzzles.charAt(i);
            int puzzleMask = 0;
            for (char c : puzzles.toCharArray()) {
                puzzleMask |= 1 << (c - 'a');
            }
            int count = 0;
            int submask = puzzleMask;
            do {
                if ((submask & (1 << (p - 'a'))) != 0) {
                    count += freq.getOrDefault(submask, 0);
                }
                submask = (submask - 1) & puzzleMask;
            } while (submask != puzzleMask);
            result.add(count);
        }
        return result;
    }
}
}