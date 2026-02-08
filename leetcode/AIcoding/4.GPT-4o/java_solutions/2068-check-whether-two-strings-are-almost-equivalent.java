class Solution {
    public boolean areAlmostEqual(String s1, String s2) {
        if (s1.length() != s2.length()) return false;
        int[] count = new int[26];
        int diffCount = 0;

        for (int i = 0; i < s1.length(); i++) {
            if (s1.charAt(i) != s2.charAt(i)) {
                diffCount++;
            }
            count[s1.charAt(i) - 'a']++;
            count[s2.charAt(i) - 'a']--;
        }

        if (diffCount == 0) return true;
        if (diffCount == 2) {
            for (int c : count) {
                if (c != 0) return false;
            }
            return true;
        }
        return false;
    }
}