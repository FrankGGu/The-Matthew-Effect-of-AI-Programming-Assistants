class Solution {
    public String breakPalindrome(String palindrome) {
        int n = palindrome.length();
        if (n == 1) {
            return "";
        }

        char[] chars = palindrome.toCharArray();

        for (int i = 0; i < n / 2; i++) {
            if (chars[i] != 'a') {
                chars[i] = 'a';
                return new String(chars);
            }
        }

        // If we reach here, it means all characters in the first half are 'a's.
        // For example, "aaaa", "aba", "aaabaaa".
        // In this case, to make it lexicographically smallest and non-palindromic,
        // we must change the last character to 'b'.
        chars[n - 1] = 'b';
        return new String(chars);
    }
}