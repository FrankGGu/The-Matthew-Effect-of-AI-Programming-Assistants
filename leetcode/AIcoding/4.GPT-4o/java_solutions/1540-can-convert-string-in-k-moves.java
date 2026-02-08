class Solution {
    public boolean canConvert(String str1, String str2, int k) {
        if (str1.length() != str2.length()) return false;
        if (str1.equals(str2)) return true;

        int n = str1.length();
        int[] count = new int[26];

        for (int i = 0; i < n; i++) {
            count[str1.charAt(i) - 'a']++;
            count[str2.charAt(i) - 'a']--;
        }

        int distinctChars = 0;
        for (int c : count) {
            if (c != 0) distinctChars++;
        }

        return distinctChars <= k || k >= 26;
    }
}