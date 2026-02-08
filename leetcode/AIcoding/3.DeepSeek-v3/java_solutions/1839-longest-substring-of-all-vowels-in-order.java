class Solution {
    public int longestBeautifulSubstring(String word) {
        int maxLen = 0;
        int currentLen = 1;
        int count = 1;

        for (int i = 1; i < word.length(); i++) {
            if (word.charAt(i) > word.charAt(i - 1)) {
                currentLen++;
                count++;
            } else if (word.charAt(i) == word.charAt(i - 1)) {
                currentLen++;
            } else {
                currentLen = 1;
                count = 1;
            }

            if (count == 5) {
                maxLen = Math.max(maxLen, currentLen);
            }
        }

        return maxLen;
    }
}