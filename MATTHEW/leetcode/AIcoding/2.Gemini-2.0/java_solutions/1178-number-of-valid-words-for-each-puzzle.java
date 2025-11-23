import java.util.*;

class Solution {
    public List<Integer> findNumOfValidWords(String[] words, String[] puzzles) {
        List<Integer> result = new ArrayList<>();
        for (String puzzle : puzzles) {
            int count = 0;
            for (String word : words) {
                if (isValid(word, puzzle)) {
                    count++;
                }
            }
            result.add(count);
        }
        return result;
    }

    private boolean isValid(String word, String puzzle) {
        char firstChar = puzzle.charAt(0);
        if (!word.contains(String.valueOf(firstChar))) {
            return false;
        }

        Set<Character> puzzleChars = new HashSet<>();
        for (char c : puzzle.toCharArray()) {
            puzzleChars.add(c);
        }

        for (char c : word.toCharArray()) {
            if (!puzzleChars.contains(c)) {
                return false;
            }
        }

        return true;
    }
}