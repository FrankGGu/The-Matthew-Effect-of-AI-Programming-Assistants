class Solution {
    int maxScore = 0;
    int[] letterCounts;
    String[] words;
    int[] scores;
    int[] wordScores;
    int[][] wordLetterFreq;

    public int maxScoreWords(String[] words, char[] letters, int[] score) {
        this.words = words;
        this.scores = score;
        this.letterCounts = new int[26];
        for (char c : letters) {
            letterCounts[c - 'a']++;
        }

        wordScores = new int[words.length];
        wordLetterFreq = new int[words.length][26];
        for (int i = 0; i < words.length; i++) {
            for (char c : words[i].toCharArray()) {
                wordLetterFreq[i][c - 'a']++;
                wordScores[i] += scores[c - 'a'];
            }
        }

        backtrack(0, 0);
        return maxScore;
    }

    private void backtrack(int wordIdx, int currentTotalScore) {
        maxScore = Math.max(maxScore, currentTotalScore);

        if (wordIdx == words.length) {
            return;
        }

        backtrack(wordIdx + 1, currentTotalScore);

        boolean canForm = true;
        for (int i = 0; i < 26; i++) {
            if (letterCounts[i] < wordLetterFreq[wordIdx][i]) {
                canForm = false;
                break;
            }
        }

        if (canForm) {
            for (int i = 0; i < 26; i++) {
                letterCounts[i] -= wordLetterFreq[wordIdx][i];
            }
            backtrack(wordIdx + 1, currentTotalScore + wordScores[wordIdx]);
            for (int i = 0; i < 26; i++) {
                letterCounts[i] += wordLetterFreq[wordIdx][i];
            }
        }
    }
}