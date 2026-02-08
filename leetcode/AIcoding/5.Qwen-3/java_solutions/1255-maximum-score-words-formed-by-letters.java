public class Solution {

import java.util.*;

public class Solution {
    public int maxScoreWords(String[] words, char[] letters) {
        int[] letterCount = new int[26];
        for (char c : letters) {
            letterCount[c - 'a']++;
        }

        int[] wordScores = new int[words.length];
        int[] wordLetterCounts = new int[words.length];

        for (int i = 0; i < words.length; i++) {
            int score = 0;
            int[] count = new int[26];
            for (char c : words[i]) {
                score += (c - 'a' + 1);
                count[c - 'a']++;
            }
            wordScores[i] = score;
            wordLetterCounts[i] = Arrays.hashCode(count);
        }

        return backtrack(0, letterCount, wordScores, wordLetterCounts);
    }

    private int backtrack(int index, int[] remainingLetters, int[] wordScores, int[] wordLetterCounts) {
        if (index == wordScores.length) {
            return 0;
        }

        int[] currentWordLetters = getWordLetters(wordLetterCounts[index]);
        int totalScore = 0;

        // Skip the current word
        totalScore = Math.max(totalScore, backtrack(index + 1, remainingLetters, wordScores, wordLetterCounts));

        // Take the current word if possible
        boolean canTake = true;
        for (int i = 0; i < 26; i++) {
            if (currentWordLetters[i] > remainingLetters[i]) {
                canTake = false;
                break;
            }
        }

        if (canTake) {
            int[] newRemaining = Arrays.copyOf(remainingLetters, 26);
            for (int i = 0; i < 26; i++) {
                newRemaining[i] -= currentWordLetters[i];
            }
            totalScore = Math.max(totalScore, wordScores[index] + backtrack(index + 1, newRemaining, wordScores, wordLetterCounts));
        }

        return totalScore;
    }

    private int[] getWordLetters(int hash) {
        int[] result = new int[26];
        for (int i = 0; i < 26; i++) {
            result[i] = (hash >> (i * 2)) & 3;
        }
        return result;
    }
}
}