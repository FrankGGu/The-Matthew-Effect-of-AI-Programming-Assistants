public class Solution {
    public int numberOfGoodStrings(String pattern1, String pattern2, String[] words) {
        int count = 0;
        for (String word : words) {
            if (isGoodString(word, pattern1, pattern2)) {
                count++;
            }
        }
        return count;
    }

    private boolean isGoodString(String word, String pattern1, String pattern2) {
        int[] count1 = new int[26];
        int[] count2 = new int[26];
        for (char c : word.toCharArray()) {
            count1[c - 'a']++;
            count2[c - 'a']++;
        }
        for (int i = 0; i < 26; i++) {
            if (count1[i] < pattern1.length() || count2[i] > pattern2.length()) {
                return false;
            }
        }
        return true;
    }
}