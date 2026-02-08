class Solution {
    public int[] vowelStrings(String[] words, int[][] queries) {
        int n = words.length;
        int[] prefixSum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            String word = words[i];
            if (isVowelString(word)) {
                prefixSum[i + 1] = prefixSum[i] + 1;
            } else {
                prefixSum[i + 1] = prefixSum[i];
            }
        }

        int m = queries.length;
        int[] result = new int[m];
        for (int i = 0; i < m; i++) {
            int start = queries[i][0];
            int end = queries[i][1];
            result[i] = prefixSum[end + 1] - prefixSum[start];
        }

        return result;
    }

    private boolean isVowelString(String word) {
        char first = word.charAt(0);
        char last = word.charAt(word.length() - 1);
        return isVowel(first) && isVowel(last);
    }

    private boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }
}