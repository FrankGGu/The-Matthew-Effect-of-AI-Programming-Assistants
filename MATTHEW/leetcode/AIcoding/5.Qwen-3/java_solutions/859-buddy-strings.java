public class Solution {
    public boolean buddyStrings(String A, String B) {
        if (A.length() != B.length()) {
            return false;
        }
        int[] count = new int[26];
        boolean hasDuplicate = false;
        for (int i = 0; i < A.length(); i++) {
            char a = A.charAt(i);
            char b = B.charAt(i);
            if (a != b) {
                if (i > 0 && A.charAt(i - 1) == b && B.charAt(i - 1) == a) {
                    return true;
                }
            } else {
                count[a - 'a']++;
                if (count[a - 'a'] >= 2) {
                    hasDuplicate = true;
                }
            }
        }
        return hasDuplicate;
    }
}