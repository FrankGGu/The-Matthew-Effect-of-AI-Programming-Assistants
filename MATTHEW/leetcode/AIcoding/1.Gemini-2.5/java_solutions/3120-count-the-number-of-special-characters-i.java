import java.util.HashSet;
import java.util.Set;

class Solution {
    public int numberOfSpecialChars(String s) {
        boolean[] seenLower = new boolean[26];
        boolean[] seenUpper = new boolean[26];

        for (char c : s.toCharArray()) {
            if (c >= 'a' && c <= 'z') {
                seenLower[c - 'a'] = true;
            } else if (c >= 'A' && c <= 'Z') {
                seenUpper[c - 'A'] = true;
            }
        }

        int count = 0;
        for (int i = 0; i < 26; i++) {
            if (seenLower[i] && seenUpper[i]) {
                count++;
            }
        }

        return count;
    }
}