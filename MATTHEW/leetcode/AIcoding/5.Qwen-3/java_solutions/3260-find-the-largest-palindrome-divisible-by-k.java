public class Solution {
    public String largestPalindrome(int n, int k) {
        if (n == 1) {
            return "9";
        }
        int max = (int) Math.pow(10, n) - 1;
        int min = (int) Math.pow(10, n - 1);
        for (int i = max; i >= min; i--) {
            String s = String.valueOf(i);
            String palindrome = s + new StringBuilder(s).reverse().toString();
            long num = Long.parseLong(palindrome);
            if (num % k == 0) {
                return palindrome;
            }
        }
        return "";
    }
}