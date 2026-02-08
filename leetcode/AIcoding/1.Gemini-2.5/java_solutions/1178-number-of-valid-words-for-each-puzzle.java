import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public List<Integer> findNumOfValidWords(String[] words, String[] puzzles) {
        Map<Integer, Integer> wordMaskCounts = new HashMap<>();
        for (String word : words) {
            int mask = 0;
            for (char c : word.toCharArray()) {
                mask |= (1 << (c - 'a'));
            }
            wordMaskCounts.put(mask, wordMaskCounts.getOrDefault(mask, 0) + 1);
        }

        List<Integer> result = new ArrayList<>();
        for (String puzzle : puzzles) {
            int puzzleMask = 0;
            for (char c : puzzle.toCharArray()) {
                puzzleMask |= (1 << (c - 'a'));
            }

            int firstCharMask = (1 << (puzzle.charAt(0) - 'a'));
            int currentPuzzleValidWords = 0;

            for (int sub = puzzleMask; sub > 0; sub = (sub - 1) & puzzleMask) {
                if ((sub & firstCharMask) == firstCharMask) {
                    if (wordMaskCounts.containsKey(sub)) {
                        currentPuzzleValidWords += wordMaskCounts.get(sub);
                    }
                }
            }
            result.add(currentPuzzleValidWords);
        }

        return result;
    }
}