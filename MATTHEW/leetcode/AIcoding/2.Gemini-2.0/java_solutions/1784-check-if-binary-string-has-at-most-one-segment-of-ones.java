class Solution {
    public boolean checkOnesSegment(String s) {
        int firstZero = -1;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '0') {
                firstZero = i;
                break;
            }
        }

        if (firstZero == -1) {
            return true;
        }

        for (int i = firstZero; i < s.length(); i++) {
            if (s.charAt(i) == '1') {
                return false;
            }
        }

        return true;
    }
}