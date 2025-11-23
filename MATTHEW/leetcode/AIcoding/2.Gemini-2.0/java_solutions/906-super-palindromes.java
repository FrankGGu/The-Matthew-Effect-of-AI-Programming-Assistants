class Solution {
    public int superpalindromesInRange(String left, String right) {
        long l = Long.parseLong(left);
        long r = Long.parseLong(right);
        int count = 0;

        for (long i = 1; i < 100000; i++) {
            String s = String.valueOf(i);
            String t = new StringBuilder(s).reverse().toString();
            long num = Long.parseLong(s + t);
            long sq = num * num;
            if (sq >= l && sq <= r && isPalindrome(sq)) {
                count++;
            }
        }

        for (long i = 1; i < 100000; i++) {
            String s = String.valueOf(i);
            String t = new StringBuilder(s).reverse().substring(1);
            long num = Long.parseLong(s + t);
            long sq = num * num;
            if (sq >= l && sq <= r && isPalindrome(sq)) {
                count++;
            }
        }

        return count;
    }

    private boolean isPalindrome(long n) {
        String s = String.valueOf(n);
        int len = s.length();
        for (int i = 0; i < len / 2; i++) {
            if (s.charAt(i) != s.charAt(len - i - 1)) {
                return false;
            }
        }
        return true;
    }
}