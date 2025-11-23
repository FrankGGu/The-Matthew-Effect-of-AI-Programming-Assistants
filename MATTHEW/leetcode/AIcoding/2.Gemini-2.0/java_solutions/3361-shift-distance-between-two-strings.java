class Solution {
    public int shiftDistance(String s, String t) {
        if (s.length() != t.length()) {
            return -1;
        }

        String ss = s + s;
        int index = ss.indexOf(t);

        if (index == -1) {
            return -1;
        }

        return index;
    }
}