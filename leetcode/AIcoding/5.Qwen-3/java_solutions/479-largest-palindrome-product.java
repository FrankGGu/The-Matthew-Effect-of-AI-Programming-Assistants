public class Solution {
    public int largestPalindrome(int n) {
        if (n == 1) return 9;
        int max = (int) Math.pow(10, n) - 1;
        int min = (int) Math.pow(10, n - 1);
        for (int i = max; i >= min; i--) {
            long palindrome = createPalindrome(i);
            for (int j = max; j >= min; j--) {
                if (palindrome / j > max) break;
                if (palindrome % j == 0) return (int) (palindrome % 1337);
            }
        }
        return -1;
    }

    private long createPalindrome(int i) {
        String s = String.valueOf(i);
        return Long.parseLong(s + new StringBuilder(s).reverse().toString());
    }
}