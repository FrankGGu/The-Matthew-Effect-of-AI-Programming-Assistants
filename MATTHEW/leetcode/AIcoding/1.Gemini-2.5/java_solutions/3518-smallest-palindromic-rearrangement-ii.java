class Solution {
    public String smallestPalindromicRearrangement(String s) {
        int[] counts = new int[26];
        for (char ch : s.toCharArray()) {
            counts[ch - 'a']++;
        }

        StringBuilder firstHalf = new StringBuilder();
        char middleChar = 0;

        for (int i = 0; i < 26; i++) {
            char ch = (char) ('a' + i);
            if (counts[i] % 2 == 1) {
                middleChar = ch;
                counts[i]--; 
            }
            for (int j = 0; j < counts[i] / 2; j++) {
                firstHalf.append(ch);
            }
        }

        StringBuilder result = new StringBuilder(firstHalf);
        if (middleChar != 0) {
            result.append(middleChar);
        }
        result.append(firstHalf.reverse());

        return result.toString();
    }
}