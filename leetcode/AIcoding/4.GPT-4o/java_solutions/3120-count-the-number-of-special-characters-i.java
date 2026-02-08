class Solution {
    public int countSpecialCharacters(String s) {
        int count = 0;
        for (char c : s.toCharArray()) {
            if (!Character.isLetterOrDigit(c)) {
                count++;
            }
        }
        return count;
    }
}