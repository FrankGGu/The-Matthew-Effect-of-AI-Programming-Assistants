class Solution {
    public boolean checkOnesSegment(String s) {
        boolean foundZero = false;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '0') {
                foundZero = true;
            } else {
                if (foundZero) {
                    return false;
                }
            }
        }
        return true;
    }
}