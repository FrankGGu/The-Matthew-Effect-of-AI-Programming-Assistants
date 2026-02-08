class Solution {
    public int countStrings(String[] words, String s) {
        int count = 0;
        for (String word : words) {
            if (canRearrange(word, s)) {
                count++;
            }
        }
        return count;
    }

    private boolean canRearrange(String word, String s) {
        int[] freqWord = new int[26];
        int[] freqS = new int[26];

        for (char c : word.toCharArray()) {
            freqWord[c - 'a']++;
        }
        for (char c : s.toCharArray()) {
            freqS[c - 'a']++;
        }

        for (int i = 0; i < 26; i++) {
            if (freqS[i] > freqWord[i]) {
                return false;
            }
        }
        return true;
    }
}