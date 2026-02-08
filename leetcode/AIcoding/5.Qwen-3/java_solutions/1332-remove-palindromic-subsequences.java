public class Solution {
    public int removePalindromeSub(String s) {
        if (s == null || s.length() == 0) return 0;
        int left = 0;
        int right = s.length() - 1;
        while (left < right) {
            if (s.charAt(left) != s.charAt(right)) {
                return 1;
            }
            left++;
            right--;
        }
        return 1;
    }
}