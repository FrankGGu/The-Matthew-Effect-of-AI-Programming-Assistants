class Solution {
    public String kthPalindrome(int n, int k) {
        int halfLength = (n + 1) / 2;
        long start = (long) Math.pow(10, halfLength - 1);
        long palindrome = start + k - 1;

        if (palindrome >= start * 10) {
            return "";
        }

        StringBuilder sb = new StringBuilder(String.valueOf(palindrome));
        String result = sb.toString();
        if (n % 2 == 0) {
            sb.reverse();
            result += sb.toString();
        } else {
            sb.deleteCharAt(sb.length() - 1);
            sb.reverse();
            result += sb.toString();
        }

        return result;
    }
}