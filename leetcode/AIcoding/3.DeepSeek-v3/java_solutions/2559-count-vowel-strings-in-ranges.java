class Solution {
    public int[] vowelStrings(String[] words, int[][] queries) {
        int n = words.length;
        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            String word = words[i];
            boolean isVowel = isVowel(word.charAt(0)) && isVowel(word.charAt(word.length() - 1));
            prefix[i + 1] = prefix[i] + (isVowel ? 1 : 0);
        }
        int[] res = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int l = queries[i][0];
            int r = queries[i][1];
            res[i] = prefix[r + 1] - prefix[l];
        }
        return res;
    }

    private boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }
}