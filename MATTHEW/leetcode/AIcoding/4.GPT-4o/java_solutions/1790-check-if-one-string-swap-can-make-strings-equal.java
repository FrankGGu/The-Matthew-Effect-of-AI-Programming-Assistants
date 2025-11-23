class Solution {
    public boolean areAlmostEqual(String s1, String s2) {
        if (s1.length() != s2.length()) return false;
        if (s1.equals(s2)) return true;

        int[] diff = new int[4];
        int index = 0;

        for (int i = 0; i < s1.length(); i++) {
            if (s1.charAt(i) != s2.charAt(i)) {
                if (index == 4) return false;
                diff[index++] = i;
            }
        }

        return index == 2 && s1.charAt(diff[0]) == s2.charAt(diff[1]) && s1.charAt(diff[1]) == s2.charAt(diff[0]);
    }
}