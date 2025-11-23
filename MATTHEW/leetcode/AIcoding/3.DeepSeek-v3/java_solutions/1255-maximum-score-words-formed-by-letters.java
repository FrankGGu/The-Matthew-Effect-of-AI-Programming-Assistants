class Solution {
    public int maxScoreWords(String[] words, char[] letters, int[] score) {
        int[] count = new int[26];
        for (char c : letters) {
            count[c - 'a']++;
        }
        return backtrack(words, count, score, 0);
    }

    private int backtrack(String[] words, int[] count, int[] score, int index) {
        if (index == words.length) {
            return 0;
        }
        int maxScore = backtrack(words, count, score, index + 1);
        String word = words[index];
        boolean canForm = true;
        int wordScore = 0;
        int[] tempCount = count.clone();
        for (char c : word.toCharArray()) {
            if (tempCount[c - 'a'] == 0) {
                canForm = false;
                break;
            }
            tempCount[c - 'a']--;
            wordScore += score[c - 'a'];
        }
        if (canForm) {
            maxScore = Math.max(maxScore, wordScore + backtrack(words, tempCount, score, index + 1));
        }
        return maxScore;
    }
}