import java.util.Arrays;

class Solution {
    public String makeSmallestPalindrome(String s) {
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }

        int oddCount = 0;
        for (int i = 0; i < 26; i++) {
            if (count[i] % 2 != 0) {
                oddCount++;
            }
        }

        if (oddCount > 1) {
            return "";
        }

        StringBuilder sb = new StringBuilder();
        String mid = "";
        for (int i = 0; i < 26; i++) {
            if (count[i] % 2 != 0) {
                mid = String.valueOf((char) ('a' + i));
            }
            for (int j = 0; j < count[i] / 2; j++) {
                sb.append((char) ('a' + i));
            }
        }

        String firstHalf = sb.toString();
        String secondHalf = new StringBuilder(firstHalf).reverse().toString();

        return firstHalf + mid + secondHalf;
    }
}