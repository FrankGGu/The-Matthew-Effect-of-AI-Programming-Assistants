class Solution {
    public int maxRepOpt1(String text) {
        int[] count = new int[26];
        for (char c : text.toCharArray()) {
            count[c - 'a']++;
        }

        int maxLen = 0;
        int n = text.length();

        for (int i = 0; i < n; i++) {
            char currentChar = text.charAt(i);
            int length = 1;
            int j = i + 1;

            while (j < n && text.charAt(j) == currentChar) {
                length++;
                j++;
            }

            int total = length;
            if (i > 0 && j < n && text.charAt(i - 1) == text.charAt(j)) {
                total++;
            }

            if (count[currentChar - 'a'] > length) {
                total = Math.min(total + 1, count[currentChar - 'a']);
            }

            maxLen = Math.max(maxLen, total);
            i = j - 1;
        }

        return maxLen;
    }
}