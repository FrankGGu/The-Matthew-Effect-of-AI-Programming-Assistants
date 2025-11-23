class Solution {
    public int maxLengthBetweenEqualCharacters(String s) {
        int[] firstOccurrence = new int[26];
        Arrays.fill(firstOccurrence, -1);
        int maxLength = -1;

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (firstOccurrence[c - 'a'] == -1) {
                firstOccurrence[c - 'a'] = i;
            } else {
                maxLength = Math.max(maxLength, i - firstOccurrence[c - 'a'] - 1);
            }
        }
        return maxLength;
    }
}