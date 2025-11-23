class Solution {
    public int totalCharacters(String[] words, String chars) {
        int[] charCount = new int[26];
        for (char c : chars.toCharArray()) {
            charCount[c - 'a']++;
        }

        int total = 0;
        for (String word : words) {
            int[] tempCount = charCount.clone();
            boolean canForm = true;
            for (char c : word.toCharArray()) {
                if (tempCount[c - 'a'] == 0) {
                    canForm = false;
                    break;
                }
                tempCount[c - 'a']--;
            }
            if (canForm) {
                total += word.length();
            }
        }
        return total;
    }
}