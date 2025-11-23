public class Solution {
    public int largestPalindrome(int n) {
        if (n == 1) return 9;
        long upper = (long) Math.pow(10, n) - 1;
        long lower = (long) Math.pow(10, n - 1);
        long max = 0;

        for (long i = upper; i >= lower; i--) {
            long pal = createPalindrome(i);
            for (long j = upper; j * j >= pal; j--) {
                if (pal % j == 0 && pal / j >= lower) {
                    max = Math.max(max, pal);
                    break;
                }
            }
        }
        return (int) (max % 1337);
    }

    private long createPalindrome(long num) {
        StringBuilder sb = new StringBuilder(String.valueOf(num));
        return Long.parseLong(sb.append(new StringBuilder(sb).reverse()).toString());
    }
}