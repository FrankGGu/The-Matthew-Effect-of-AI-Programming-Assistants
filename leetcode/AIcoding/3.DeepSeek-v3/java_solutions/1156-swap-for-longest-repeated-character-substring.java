class Solution {
    public int maxRepOpt1(String text) {
        int[] count = new int[26];
        for (char c : text.toCharArray()) {
            count[c - 'a']++;
        }

        int maxLen = 0;
        for (int i = 0; i < text.length(); ) {
            char currentChar = text.charAt(i);
            int j = i;
            while (j < text.length() && text.charAt(j) == currentChar) {
                j++;
            }
            int k = j + 1;
            while (k < text.length() && text.charAt(k) == currentChar) {
                k++;
            }
            int len = k - i;
            if (count[currentChar - 'a'] > len) {
                len++;
            }
            maxLen = Math.max(maxLen, Math.min(len, count[currentChar - 'a']));
            i = j;
        }
        return maxLen;
    }
}