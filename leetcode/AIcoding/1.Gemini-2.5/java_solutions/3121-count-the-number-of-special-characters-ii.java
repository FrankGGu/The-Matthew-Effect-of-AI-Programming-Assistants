import java.util.Arrays;

class Solution {
    public int numberOfSpecialChars(String s) {
        int[] lastLower = new int[26];
        Arrays.fill(lastLower, -1);

        int[] firstUpper = new int[26];
        Arrays.fill(firstUpper, -1);

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c >= 'a' && c <= 'z') {
                lastLower[c - 'a'] = i;
            } else if (c >= 'A' && c <= 'Z') {
                if (firstUpper[c - 'A'] == -1) {
                    firstUpper[c - 'A'] = i;
                }
            }
        }

        int specialCount = 0;
        for (int i = 0; i < 26; i++) {
            if (lastLower[i] != -1 && firstUpper[i] != -1) {
                if (lastLower[i] < firstUpper[i]) {
                    specialCount++;
                }
            }
        }

        return specialCount;
    }
}