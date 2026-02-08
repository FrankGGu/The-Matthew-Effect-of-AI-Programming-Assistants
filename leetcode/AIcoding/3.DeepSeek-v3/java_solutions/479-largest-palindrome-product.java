class Solution {
    public int largestPalindrome(int n) {
        if (n == 1) return 9;
        int upper = (int) Math.pow(10, n) - 1;
        int lower = (int) Math.pow(10, n - 1);
        long max = (long) upper * (long) upper;
        int firstHalf = (int) (max / (long) Math.pow(10, n));

        boolean found = false;
        long palindrome = 0;

        while (!found) {
            palindrome = createPalindrome(firstHalf);

            for (long i = upper; i >= lower; i--) {
                if (i * i < palindrome) break;
                if (palindrome % i == 0) {
                    found = true;
                    break;
                }
            }

            firstHalf--;
        }

        return (int) (palindrome % 1337);
    }

    private long createPalindrome(int num) {
        String str = num + new StringBuilder().append(num).reverse().toString();
        return Long.parseLong(str);
    }
}