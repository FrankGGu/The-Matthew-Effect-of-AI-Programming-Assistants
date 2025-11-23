class Solution {
    public String longestNiceSubstring(String s) {
        int maxLength = 0;
        String longestSubstring = "";

        for (int i = 0; i < s.length(); i++) {
            for (int j = i + 1; j <= s.length(); j++) {
                String substring = s.substring(i, j);
                if (isNice(substring) && substring.length() > maxLength) {
                    maxLength = substring.length();
                    longestSubstring = substring;
                }
            }
        }

        return longestSubstring;
    }

    private boolean isNice(String s) {
        Set<Character> chars = new HashSet<>();
        for (char c : s.toCharArray()) {
            chars.add(c);
        }
        for (char c : s.toCharArray()) {
            if (Character.isLowerCase(c) && !chars.contains(Character.toUpperCase(c))) {
                return false;
            }
            if (Character.isUpperCase(c) && !chars.contains(Character.toLowerCase(c))) {
                return false;
            }
        }
        return true;
    }
}