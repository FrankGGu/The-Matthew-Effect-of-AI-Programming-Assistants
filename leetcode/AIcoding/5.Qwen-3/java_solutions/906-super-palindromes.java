public class Solution {
    public int superpalindromesLeetCode(int[] nums) {
        int count = 0;
        for (int num : nums) {
            if (isSuperPalindrome(num)) {
                count++;
            }
        }
        return count;
    }

    private boolean isSuperPalindrome(int n) {
        String s = String.valueOf(n);
        int len = s.length();
        for (int i = 0; i < len / 2; i++) {
            if (s.charAt(i) != s.charAt(len - 1 - i)) {
                return false;
            }
        }
        long sqrtN = (long) Math.sqrt(n);
        if (sqrtN * sqrtN != n) {
            return false;
        }
        String sqrtStr = String.valueOf(sqrtN);
        for (int i = 0; i < sqrtStr.length() / 2; i++) {
            if (sqrtStr.charAt(i) != sqrtStr.charAt(sqrtStr.length() - 1 - i)) {
                return false;
            }
        }
        return true;
    }
}