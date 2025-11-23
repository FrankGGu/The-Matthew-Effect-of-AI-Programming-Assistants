import java.util.Arrays;

class Solution {
    public int totalCharacters(String[] words) {
        int[] target = new int[26];
        for (String word : words) {
            int[] count = new int[26];
            for (char c : word.toCharArray()) {
                count[c - 'a']++;
            }
            for (int i = 0; i < 26; i++) {
                target[i] = Math.max(target[i], count[i]);
            }
        }
        return Arrays.stream(target).sum();
    }
}