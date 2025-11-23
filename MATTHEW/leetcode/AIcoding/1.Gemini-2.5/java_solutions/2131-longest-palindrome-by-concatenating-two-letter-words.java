class Solution {
    public int longestPalindrome(String[] words) {
        int[][] counts = new int[26][26];
        for (String word : words) {
            counts[word.charAt(0) - 'a'][word.charAt(1) - 'a']++;
        }

        int ans = 0;
        boolean oddPalindromeFound = false;

        for (int i = 0; i < 26; i++) {
            for (int j = 0; j < 26; j++) {
                if (counts[i][j] == 0) {
                    continue;
                }

                if (i == j) { // Palindromic word like "aa"
                    ans += (counts[i][j] / 2) * 4;
                    if (counts[i][j] % 2 == 1) {
                        oddPalindromeFound = true;
                    }
                    counts[i][j] = 0; // Mark as processed
                } else { // Non-palindromic word like "ab"
                    // Check for its reverse "ba"
                    if (counts[j][i] > 0) {
                        int numPairs = Math.min(counts[i][j], counts[j][i]);
                        ans += numPairs * 4;
                        counts[i][j] = 0; // Mark as processed
                        counts[j][i] = 0; // Mark its reverse as processed
                    }
                }
            }
        }

        if (oddPalindromeFound) {
            ans += 2;
        }

        return ans;
    }
}