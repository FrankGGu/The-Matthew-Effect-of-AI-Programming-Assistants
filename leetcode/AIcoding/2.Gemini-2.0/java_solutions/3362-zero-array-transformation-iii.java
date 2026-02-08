class Solution {
    public boolean canConvert(String s, String t) {
        if (s.length() != t.length()) return false;
        if (s.equals(t)) return true;

        int[] count = new int[26];
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) < t.charAt(i)) return false;
        }

        return true;
    }
}