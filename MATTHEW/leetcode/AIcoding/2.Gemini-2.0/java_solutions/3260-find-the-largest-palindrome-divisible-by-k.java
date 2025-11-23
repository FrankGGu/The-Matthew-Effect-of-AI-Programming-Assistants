class Solution {
    public String largestPalindrome(int n, int k) {
        if (n == 1) {
            return k > 9 ? "-1" : String.valueOf(k - 1);
        }

        long max = (long) Math.pow(10, n) - 1;
        long min = (long) Math.pow(10, n - 1);

        for (long i = max; i >= min; i--) {
            String s = String.valueOf(i);
            String reversedS = new StringBuilder(s).reverse().toString();
            long palindrome = Long.parseLong(s + reversedS);

            if (palindrome % k == 0) {
                return String.valueOf(palindrome);
            }
        }

        return "-1";
    }
}