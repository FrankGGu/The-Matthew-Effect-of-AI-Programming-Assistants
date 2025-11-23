class Solution {
    public boolean findValidPair(String s) {
        for (int i = 0; i < s.length() - 1; i++) {
            char char1 = s.charAt(i);
            char char2 = s.charAt(i + 1);
            if (Character.isDigit(char1) && Character.isDigit(char2) && char1 == char2) {
                return true;
            }
        }
        return false;
    }
}