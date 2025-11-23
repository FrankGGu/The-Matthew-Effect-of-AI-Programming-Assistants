class Solution {
    public int maxScoreWords(String[] words, char[] letters, int[] score) {
        int[] count = new int[26];
        for (char c : letters) {
            count[c - 'a']++;
        }
        return maxScore(words, count, score, 0);
    }

    private int maxScore(String[] words, int[] count, int[] score, int index) {
        if (index == words.length) {
            return 0;
        }

        int skip = maxScore(words, count, score, index + 1);
        int currentScore = 0;
        int[] newCount = count.clone();
        boolean valid = true;

        for (char c : words[index].toCharArray()) {
            int charIndex = c - 'a';
            if (newCount[charIndex] == 0) {
                valid = false;
                break;
            }
            newCount[charIndex]--;
            currentScore += score[charIndex];
        }

        if (!valid) {
            return skip;
        }

        int take = currentScore + maxScore(words, newCount, score, index + 1);
        return Math.max(skip, take);
    }
}