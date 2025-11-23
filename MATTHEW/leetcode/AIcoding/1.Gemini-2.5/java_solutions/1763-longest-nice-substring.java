class Solution {
    public String longestNiceSubstring(String s) {
        String longestNice = "";
        int n = s.length();

        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                String sub = s.substring(i, j + 1);
                if (isNice(sub)) {
                    if (sub.length() > longestNice.length()) {
                        longestNice = sub;
                    }
                }
            }
        }
        return longestNice;
    }

    private boolean isNice(String sub) {
        boolean[] lowerPresent = new boolean[26];
        boolean[] upperPresent = new boolean[26];

        for (char c : sub.toCharArray()) {
            if (Character.isLowerCase(c)) {
                lowerPresent[c - 'a'] = true;
            } else {
                upperPresent[c - 'A'] = true;
            }
        }

        for (int i = 0; i < 26; i++) {
            if (lowerPresent[i] != upperPresent[i]) {
                return false;
            }
        }
        return true;
    }
}