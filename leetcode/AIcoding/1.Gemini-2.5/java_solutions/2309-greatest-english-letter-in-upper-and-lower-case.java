class Solution {
    public String greatestLetter(String s) {
        boolean[] lowerCasePresent = new boolean[26];
        boolean[] upperCasePresent = new boolean[26];

        for (char c : s.toCharArray()) {
            if (c >= 'a' && c <= 'z') {
                lowerCasePresent[c - 'a'] = true;
            } else if (c >= 'A' && c <= 'Z') {
                upperCasePresent[c - 'A'] = true;
            }
        }

        for (int i = 25; i >= 0; i--) {
            if (lowerCasePresent[i] && upperCasePresent[i]) {
                return String.valueOf((char) ('A' + i));
            }
        }

        return "";
    }
}