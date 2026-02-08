import java.util.Arrays;

class Solution {
    public String shortestCompletingWord(String licensePlate, String[] words) {
        int[] licenseCounts = new int[26];
        for (char c : licensePlate.toCharArray()) {
            if (Character.isLetter(c)) {
                licenseCounts[Character.toLowerCase(c) - 'a']++;
            }
        }

        String shortestWord = null;
        for (String word : words) {
            int[] wordCounts = new int[26];
            for (char c : word.toCharArray()) {
                wordCounts[c - 'a']++;
            }

            boolean complete = true;
            for (int i = 0; i < 26; i++) {
                if (licenseCounts[i] > wordCounts[i]) {
                    complete = false;
                    break;
                }
            }

            if (complete) {
                if (shortestWord == null || word.length() < shortestWord.length()) {
                    shortestWord = word;
                }
            }
        }

        return shortestWord;
    }
}