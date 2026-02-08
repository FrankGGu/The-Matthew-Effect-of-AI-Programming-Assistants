class Solution {
    public int minCut(String s) {
        int n = s.length();
        boolean[][] isPalindrome = new boolean[n][n];
        int[] cuts = new int[n];

        for (int i = 0; i < n; i++) {
            cuts[i] = i; // maximum cuts
            for (int j = 0; j <= i; j++) {
                if (s.charAt(j) == s.charAt(i) && (i - j < 2 || isPalindrome[j + 1][i - 1])) {
                    isPalindrome[j][i] = true;
                    cuts[i] = j == 0 ? 0 : Math.min(cuts[i], cuts[j - 1] + 1);
                }
            }
        }
        return cuts[n - 1];
    }
}