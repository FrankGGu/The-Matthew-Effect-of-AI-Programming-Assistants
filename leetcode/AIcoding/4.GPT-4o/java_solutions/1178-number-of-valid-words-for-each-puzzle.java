import java.util.*;

class Solution {
    public List<Integer> findNumOfValidWords(String[] words, String[] puzzles) {
        Map<Integer, Integer> wordCount = new HashMap<>();
        for (String word : words) {
            int mask = 0;
            for (char c : word.toCharArray()) {
                mask |= 1 << (c - 'a');
            }
            wordCount.put(mask, wordCount.getOrDefault(mask, 0) + 1);
        }

        List<Integer> result = new ArrayList<>();
        for (String puzzle : puzzles) {
            int firstCharMask = 1 << (puzzle.charAt(0) - 'a');
            int puzzleMask = 0;
            for (char c : puzzle.toCharArray()) {
                puzzleMask |= 1 << (c - 'a');
            }

            int count = 0;
            for (int wordMask : wordCount.keySet()) {
                if ((wordMask & puzzleMask) == wordMask && (wordMask & firstCharMask) != 0) {
                    count += wordCount.get(wordMask);
                }
            }
            result.add(count);
        }
        return result;
    }
}