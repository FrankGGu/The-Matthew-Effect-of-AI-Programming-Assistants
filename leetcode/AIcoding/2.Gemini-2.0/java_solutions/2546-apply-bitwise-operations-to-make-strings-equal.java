class Solution {
    public boolean makeStringsEqual(String s1, String s2) {
        if (s1.equals(s2)) {
            return true;
        }

        boolean hasOne1 = false;
        boolean hasOne2 = false;

        for (int i = 0; i < s1.length(); i++) {
            if (s1.charAt(i) == '1') {
                hasOne1 = true;
            }
            if (s2.charAt(i) == '1') {
                hasOne2 = true;
            }
        }

        if (hasOne1 && hasOne2) {
            return true;
        }

        return false;
    }
}