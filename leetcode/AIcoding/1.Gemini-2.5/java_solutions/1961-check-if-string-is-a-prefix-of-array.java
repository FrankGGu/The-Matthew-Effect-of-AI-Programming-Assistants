class Solution {
    public boolean isPrefixString(String s, String[] words) {
        StringBuilder currentPrefix = new StringBuilder();
        for (String word : words) {
            currentPrefix.append(word);
            if (currentPrefix.length() == s.length()) {
                if (currentPrefix.toString().equals(s)) {
                    return true;
                }
            } else if (currentPrefix.length() > s.length()) {
                return false;
            }
        }
        return false;
    }
}