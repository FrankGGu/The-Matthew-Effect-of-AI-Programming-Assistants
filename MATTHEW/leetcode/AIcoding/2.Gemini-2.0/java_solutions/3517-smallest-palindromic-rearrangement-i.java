import java.util.Arrays;

class Solution {
    public String smallestPalindrome(String s) {
        int[] counts = new int[26];
        for (char c : s.toCharArray()) {
            counts[c - 'a']++;
        }

        int oddCount = 0;
        for (int count : counts) {
            if (count % 2 != 0) {
                oddCount++;
            }
        }

        if (oddCount > 1) {
            return "";
        }

        StringBuilder sb = new StringBuilder();
        StringBuilder middle = new StringBuilder();

        for (int i = 0; i < 26; i++) {
            if (counts[i] % 2 == 0) {
                for (int j = 0; j < counts[i] / 2; j++) {
                    sb.append((char) ('a' + i));
                }
            } else {
                for (int j = 0; j < counts[i]; j++) {
                    middle.append((char) ('a' + i));
                }
            }
        }

        String firstHalf = sb.toString();
        String secondHalf = new StringBuilder(firstHalf).reverse().toString();

        return firstHalf + middle.toString() + secondHalf;
    }
}