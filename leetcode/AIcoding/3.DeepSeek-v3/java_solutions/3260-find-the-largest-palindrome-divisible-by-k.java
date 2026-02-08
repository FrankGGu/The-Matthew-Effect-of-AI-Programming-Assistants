class Solution {
    public int largestPalindrome(int n) {
        if (n == 1) {
            return 9;
        }
        int upper = (int) Math.pow(10, n) - 1;
        int lower = (int) Math.pow(10, n - 1);
        long max = 0;
        for (int i = upper; i >= lower; i--) {
            long palindrome = createPalindrome(i);
            for (long j = upper; j * j >= palindrome; j--) {
                if (palindrome % j == 0 && palindrome / j <= upper) {
                    return (int) (palindrome % 1337);
                }
            }
        }
        return -1;
    }

    private long createPalindrome(int num) {
        String str = num + new StringBuilder().append(num).reverse().toString();
        return Long.parseLong(str);
    }
}