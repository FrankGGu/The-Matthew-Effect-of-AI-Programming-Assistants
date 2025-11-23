class Solution {
    public int applyOperationsToMakeStringEmpty(String s) {
        int n = s.length();
        if (n == 0) {
            return 0;
        }

        int[] lps = new int[n];
        for (int i = 1; i < n; i++) {
            int j = lps[i - 1];
            while (j > 0 && s.charAt(i) != s.charAt(j)) {
                j = lps[j - 1];
            }
            if (s.charAt(i) == s.charAt(j)) {
                j++;
            }
            lps[i] = j;
        }

        int operations = 0;
        int currentLength = n;

        while (currentLength > 0) {
            operations++;
            int k = lps[currentLength - 1];
            if (k > 0) {
                currentLength = k;
            } else {
                currentLength--;
            }
        }

        return operations;
    }
}