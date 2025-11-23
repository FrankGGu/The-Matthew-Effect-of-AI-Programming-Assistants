class Solution {
    public String shortestCompletingWord(String licensePlate, String[] words) {
        int[] lpCounts = new int[26];
        for (char ch : licensePlate.toCharArray()) {
            char c = Character.toLowerCase(ch);
            if (c >= 'a' && c <= 'z') {
                lpCounts[c - 'a']++;
            }
        }

        String shortestCompletingWord = null;
        int minLength = Integer.MAX_VALUE;

        for (String word : words) {
            int[] wordCounts = new int[26];
            for (char ch : word.toCharArray()) {
                wordCounts[ch - 'a']++;
            }

            boolean completes = true;
            for (int i = 0; i < 26; i++) {
                if (lpCounts[i] > wordCounts[i]) {
                    completes = false;
                    break;
                }
            }

            if (completes) {
                if (word.length() < minLength) {
                    minLength = word.length();
                    shortestCompletingWord = word;
                }
            }
        }

        return shortestCompletingWord;
    }
}