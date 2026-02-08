class Solution {
    public int findTheLongestSubstring(String s) {
        int n = s.length();
        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i];
            char c = s.charAt(i);
            if (c == 'a') {
                prefix[i + 1] ^= 1;
            } else if (c == 'e') {
                prefix[i + 1] ^= 2;
            } else if (c == 'i') {
                prefix[i + 1] ^= 4;
            } else if (c == 'o') {
                prefix[i + 1] ^= 8;
            } else if (c == 'u') {
                prefix[i + 1] ^= 16;
            }
        }

        int[] firstOccurrence = new int[32];
        Arrays.fill(firstOccurrence, -1);
        firstOccurrence[0] = 0;

        int maxLength = 0;
        for (int i = 1; i <= n; i++) {
            if (firstOccurrence[prefix[i]] == -1) {
                firstOccurrence[prefix[i]] = i;
            } else {
                maxLength = Math.max(maxLength, i - firstOccurrence[prefix[i]]);
            }
        }

        return maxLength;
    }
}