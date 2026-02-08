public class Solution {
    public int largestPalindrome(int n, int k) {
        long upper = (long) Math.pow(10, n) - 1;
        long lower = (long) Math.pow(10, n - 1);
        for (long i = upper; i >= lower; i--) {
            long palindrome = createPalindrome(i);
            if (palindrome % k == 0) {
                return (int) (palindrome % 1_000_000_007);
            }
        }
        return 0;
    }

    private long createPalindrome(long num) {
        String str = Long.toString(num);
        StringBuilder sb = new StringBuilder(str).reverse();
        return Long.parseLong(str + sb.toString());
    }
}