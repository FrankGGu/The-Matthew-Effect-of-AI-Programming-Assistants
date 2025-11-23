class Solution {
    public int superpalindromesInRange(String left, String right) {
        long L = Long.parseLong(left);
        long R = Long.parseLong(right);
        int count = 0;

        for (long k = 1; k < 100000; k++) {
            String s = Long.toString(k);
            StringBuilder sb = new StringBuilder(s);
            String rev = sb.reverse().toString();

            long palEven = Long.parseLong(s + rev);
            long palEvenSq = palEven * palEven;
            if (palEvenSq > R) break;
            if (palEvenSq >= L && isPalindrome(palEvenSq)) {
                count++;
            }

            long palOdd = Long.parseLong(s + rev.substring(1));
            long palOddSq = palOdd * palOdd;
            if (palOddSq >= L && palOddSq <= R && isPalindrome(palOddSq)) {
                count++;
            }
        }

        return count;
    }

    private boolean isPalindrome(long num) {
        long original = num;
        long reversed = 0;
        while (num > 0) {
            reversed = reversed * 10 + num % 10;
            num /= 10;
        }
        return original == reversed;
    }
}