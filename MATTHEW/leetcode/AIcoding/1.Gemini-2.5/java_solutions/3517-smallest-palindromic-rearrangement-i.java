import java.util.Arrays;

class Solution {
    public String smallestPalindromicRearrangement(String s) {
        if (s == null || s.length() == 0) {
            return "";
        }

        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }

        StringBuilder leftHalf = new StringBuilder();
        char middleChar = '\0'; 

        for (int i = 0; i < 26; i++) {
            char currentChar = (char) ('a' + i);
            if (freq[i] % 2 == 1) {
                middleChar = currentChar;
                freq[i]--; 
            }
            for (int j = 0; j < freq[i] / 2; j++) {
                leftHalf.append(currentChar);
            }
        }

        StringBuilder rightHalf = new StringBuilder(leftHalf).reverse();

        if (middleChar != '\0') {
            return leftHalf.toString() + middleChar + rightHalf.toString();
        } else {
            return leftHalf.toString() + rightHalf.toString();
        }
    }
}