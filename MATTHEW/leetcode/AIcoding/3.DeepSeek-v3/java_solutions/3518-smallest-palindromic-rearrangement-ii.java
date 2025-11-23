class Solution {
    public String smallestPalindrome(String s) {
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }

        StringBuilder leftHalf = new StringBuilder();
        char middle = '\0';

        for (int i = 0; i < 26; i++) {
            if (count[i] == 0) continue;
            char c = (char)('a' + i);
            while (count[i] >= 2) {
                leftHalf.append(c);
                count[i] -= 2;
            }
            if (count[i] == 1 && middle == '\0') {
                middle = c;
            }
        }

        String palindrome = leftHalf.toString() + (middle != '\0' ? String.valueOf(middle) : "") + leftHalf.reverse().toString();
        return palindrome;
    }
}