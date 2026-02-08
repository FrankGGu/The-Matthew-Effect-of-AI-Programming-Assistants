class Solution {
    public int[] vowelStrings(String[] words, int[][] queries) {
        int n = words.length;
        int[] prefixSum = new int[n + 1];

        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i];
            if (isVowelString(words[i])) {
                prefixSum[i + 1]++;
            }
        }

        int[] ans = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int start = queries[i][0];
            int end = queries[i][1];
            ans[i] = prefixSum[end + 1] - prefixSum[start];
        }

        return ans;
    }

    private boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }

    private boolean isVowelString(String s) {
        if (s.isEmpty()) {
            return false;
        }
        char first = s.charAt(0);
        char last = s.charAt(s.length() - 1);
        return isVowel(first) && isVowel(last);
    }
}