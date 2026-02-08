import java.util.HashMap;

public class Solution {
    public int maxScoreWords(String[] words, int[] scores, int letters) {
        return backtrack(words, scores, new HashMap<>(), 0, letters);
    }

    private int backtrack(String[] words, int[] scores, HashMap<Character, Integer> count, int index, int letters) {
        if (index == words.length) {
            return 0;
        }

        int maxScore = backtrack(words, scores, count, index + 1, letters);

        int wordScore = 0;
        boolean canFormWord = true;
        for (char c : words[index].toCharArray()) {
            count.put(c, count.getOrDefault(c, 0) + 1);
            wordScore += scores[c - 'a'];
            if (count.get(c) > letters) {
                canFormWord = false;
            }
        }

        if (canFormWord) {
            maxScore = Math.max(maxScore, wordScore + backtrack(words, scores, count, index + 1, letters - words[index].length()));
        }

        for (char c : words[index].toCharArray()) {
            count.put(c, count.get(c) - 1);
        }

        return maxScore;
    }
}