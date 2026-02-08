class Solution {
    public boolean isCircularSentence(String sentence) {
        String[] words = sentence.split(" ");
        int n = words.length;

        for (int i = 0; i < n - 1; i++) {
            String currentWord = words[i];
            String nextWord = words[i + 1];
            if (currentWord.charAt(currentWord.length() - 1) != nextWord.charAt(0)) {
                return false;
            }
        }

        String firstWord = words[0];
        String lastWord = words[n - 1];
        if (lastWord.charAt(lastWord.length() - 1) != firstWord.charAt(0)) {
            return false;
        }

        return true;
    }
}