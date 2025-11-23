import java.util.HashSet;

class Solution {
    public int countWords(String[] words, String letters) {
        HashSet<String> validWords = new HashSet<>();
        int letterCount[] = new int[26];

        for (char c : letters.toCharArray()) {
            letterCount[c - 'a']++;
        }

        for (String word : words) {
            int[] wordCount = new int[26];
            boolean canForm = true;

            for (char c : word.toCharArray()) {
                wordCount[c - 'a']++;
                if (wordCount[c - 'a'] > letterCount[c - 'a']) {
                    canForm = false;
                    break;
                }
            }

            if (canForm) {
                validWords.add(word);
            }
        }

        return validWords.size();
    }
}