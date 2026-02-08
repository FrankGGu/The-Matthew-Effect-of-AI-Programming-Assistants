class Solution {
    public int countCharacters(String[] words, String chars) {
        int[] charCount = new int[26];
        for (char c : chars.toCharArray()) {
            charCount[c - 'a']++;
        }

        int count = 0;
        for (String word : words) {
            int[] wordCount = new int[26];
            boolean good = true;
            for (char c : word.toCharArray()) {
                int index = c - 'a';
                wordCount[index]++;
                if (wordCount[index] > charCount[index]) {
                    good = false;
                    break;
                }
            }
            if (good) {
                count += word.length();
            }
        }
        return count;
    }
}