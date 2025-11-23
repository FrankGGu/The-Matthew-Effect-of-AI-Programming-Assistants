public class Solution {
    public boolean isStrictlyPalindromic(int n) {
        for (int i = 2; i <= n - 1; i++) {
            String s = "";
            int num = n;
            while (num > 0) {
                s = (num % i) + s;
                num /= i;
            }
            int left = 0;
            int right = s.length() - 1;
            while (left < right) {
                if (s.charAt(left) != s.charAt(right)) {
                    return false;
                }
                left++;
                right--;
            }
        }
        return true;
    }
}