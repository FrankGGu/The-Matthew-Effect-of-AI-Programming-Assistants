class Solution {
    public int longestPalindromeAfterSubstringConcatenation(String[] words) {
        int[][] count = new int[26][26];
        int ans = 0;
        int center = 0;

        for (String w : words) {
            int i = w.charAt(0) - 'a';
            int j = w.charAt(1) - 'a';

            if (count[j][i] > 0) {
                ans += 4;
                count[j][i]--;
                if (i == j) {
                    center--;
                }
            } else {
                count[i][j]++;
                if (i == j) {
                    center++;
                }
            }
        }

        if (center > 0) {
            ans += 2;
        }

        return ans;
    }
}