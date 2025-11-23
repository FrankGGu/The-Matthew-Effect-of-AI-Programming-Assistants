class Solution {
    public boolean isValid(String s) {
        for (int i = 0; i < s.length() - 1; i++) {
            char a = s.charAt(i);
            char b = s.charAt(i + 1);
            if ((a == '0' && b == '9') || (a == '9' && b == '0') ||
                (a == '1' && b == '2') || (a == '2' && b == '1') ||
                (a == '3' && b == '4') || (a == '4' && b == '3') ||
                (a == '5' && b == '6') || (a == '6' && b == '5') ||
                (a == '7' && b == '8') || (a == '8' && b == '7')) {
                return true;
            }
        }
        return false;
    }
}