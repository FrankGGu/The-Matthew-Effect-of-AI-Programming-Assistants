class Solution {
    public String longestNiceSubstring(String s) {
        if (s == null || s.length() < 2) {
            return "";
        }

        String result = "";
        for (int i = 0; i < s.length(); i++) {
            for (int j = i + 1; j <= s.length(); j++) {
                String sub = s.substring(i, j);
                if (isNice(sub) && sub.length() > result.length()) {
                    result = sub;
                }
            }
        }
        return result;
    }

    private boolean isNice(String s) {
        if (s.length() == 0) {
            return true;
        }
        for (char c : s.toCharArray()) {
            if (Character.isLowerCase(c)) {
                if (s.indexOf(Character.toUpperCase(c)) == -1) {
                    return false;
                }
            } else {
                if (s.indexOf(Character.toLowerCase(c)) == -1) {
                    return false;
                }
            }
        }
        return true;
    }
}