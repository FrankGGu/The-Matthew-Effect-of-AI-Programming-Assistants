public class Solution {
    public int superpalindromesInRange(String left, String right) {
        long l = Long.parseLong(left);
        long r = Long.parseLong(right);
        int count = 0;

        for (long i = 1; i * i <= r; i++) {
            String s = Long.toString(i);
            String t = new StringBuilder(s).reverse().toString();
            long palin = Long.parseLong(s + t);
            if (palin * palin > r) break;
            if (palin * palin >= l && isPalindrome(palin * palin)) count++;

            for (int j = 0; j < 10; j++) {
                palin = Long.parseLong(s + j + t);
                if (palin * palin > r) break;
                if (palin * palin >= l && isPalindrome(palin * palin)) count++;
            }
        }
        return count;
    }

    private boolean isPalindrome(long num) {
        String s = Long.toString(num);
        int left = 0, right = s.length() - 1;
        while (left < right) {
            if (s.charAt(left++) != s.charAt(right--)) return false;
        }
        return true;
    }
}