class Solution {
    public int shiftDistance(String s, String t) {
        if (s.length() != t.length()) {
            return -1;
        }

        if (s.isEmpty()) {
            return 0;
        }

        String s2 = s + s;
        int index = s2.indexOf(t);

        return index;
    }
}