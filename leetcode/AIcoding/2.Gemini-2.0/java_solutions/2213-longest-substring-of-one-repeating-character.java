class Solution {
    public int longestRepeating(String s, String queryCharacters, int[] queryIndices) {
        int n = s.length();
        int m = queryCharacters.length();
        int[] ans = new int[m];

        for (int i = 0; i < m; i++) {
            char c = queryCharacters.charAt(i);
            int index = queryIndices[i];
            StringBuilder sb = new StringBuilder(s);
            sb.setCharAt(index, c);
            String temp = sb.toString();

            int maxLen = 1;
            int currentLen = 1;
            for (int j = 1; j < n; j++) {
                if (temp.charAt(j) == temp.charAt(j - 1)) {
                    currentLen++;
                } else {
                    maxLen = Math.max(maxLen, currentLen);
                    currentLen = 1;
                }
            }
            maxLen = Math.max(maxLen, currentLen);
            ans[i] = maxLen;
        }

        return ans[0];
    }

    public int[] longestRepeating(String s, char[] queryCharacters, int[] queryIndices) {
        int n = s.length();
        int m = queryCharacters.length;
        int[] ans = new int[m];

        for (int i = 0; i < m; i++) {
            char c = queryCharacters[i];
            int index = queryIndices[i];
            StringBuilder sb = new StringBuilder(s);
            sb.setCharAt(index, c);
            String temp = sb.toString();

            int maxLen = 1;
            int currentLen = 1;
            for (int j = 1; j < n; j++) {
                if (temp.charAt(j) == temp.charAt(j - 1)) {
                    currentLen++;
                } else {
                    maxLen = Math.max(maxLen, currentLen);
                    currentLen = 1;
                }
            }
            maxLen = Math.max(maxLen, currentLen);
            ans[i] = maxLen;
        }

        return ans;
    }
}