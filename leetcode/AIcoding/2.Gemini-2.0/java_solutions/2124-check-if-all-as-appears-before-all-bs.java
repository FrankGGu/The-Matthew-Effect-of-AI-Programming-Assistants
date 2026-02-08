class Solution {
    public boolean checkString(String s) {
        boolean bFound = false;
        for (char c : s.toCharArray()) {
            if (c == 'b') {
                bFound = true;
            } else if (c == 'a' && bFound) {
                return false;
            }
        }
        return true;
    }
}