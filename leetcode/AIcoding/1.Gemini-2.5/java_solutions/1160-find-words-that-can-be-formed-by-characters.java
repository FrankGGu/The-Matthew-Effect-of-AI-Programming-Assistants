class Solution {
    public int countCharacters(String[] words, String chars) {
        int[] charFreq = new int[26];
        for (char c : chars.toCharArray()) {
            charFreq[c - 'a']++;
        }

        int totalLength = 0;
        for (String word : words) {
            int[] wordFreq = new int[26];
            for (char c : word.toCharArray()) {
                wordFreq[c - 'a']++;
            }

            boolean canForm = true;
            for (int i = 0; i < 26; i++) {
                if (wordFreq[i] > charFreq[i]) {
                    canForm = false;
                    break;
                }
            }

            if (canForm) {
                totalLength += word.length();
            }
        }

        return totalLength;
    }
}