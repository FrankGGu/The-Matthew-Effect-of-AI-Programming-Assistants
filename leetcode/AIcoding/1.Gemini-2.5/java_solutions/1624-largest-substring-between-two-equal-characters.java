class Solution {
    public int maxLengthBetweenEqualCharacters(String s) {
        int[] firstOccurrence = new int[26];
        for (int i = 0; i < 26; i++) {
            firstOccurrence[i] = -1;
        }

        int maxLength = -1;

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            int charIndex = c - 'a';

            if (firstOccurrence[charIndex] != -1) {
                maxLength = Math.max(maxLength, i - firstOccurrence[charIndex] - 1);
            } else {
                firstOccurrence[charIndex] = i;
            }
        }

        return maxLength;
    }
}