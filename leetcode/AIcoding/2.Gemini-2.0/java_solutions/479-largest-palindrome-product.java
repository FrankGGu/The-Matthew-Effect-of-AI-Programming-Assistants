class Solution {
    public int largestPalindrome(int n) {
        if (n == 1) {
            return 9;
        }

        long max = (long) Math.pow(10, n) - 1;
        long min = (long) Math.pow(10, n - 1);

        for (long i = max; i >= min; i--) {
            long palindrome = createPalindrome(i);

            for (long j = max; j * j >= palindrome; j--) {
                if (palindrome % j == 0 && palindrome / j >= min && palindrome / j <= max) {
                    return (int) (palindrome % 1337);
                }
            }
        }

        return 0;
    }

    private long createPalindrome(long n) {
        String s = String.valueOf(n);
        String reversed = new StringBuilder(s).reverse().toString();
        return Long.parseLong(s + reversed);
    }
}