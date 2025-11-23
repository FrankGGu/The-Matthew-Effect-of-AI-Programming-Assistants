class Solution {
    public int[] numSmallerByFrequency(String[] queries, String[] words) {
        int[] fWords = new int[words.length];
        for (int i = 0; i < words.length; i++) {
            fWords[i] = f(words[i]);
        }
        Arrays.sort(fWords);

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int fQuery = f(queries[i]);
            int count = 0;
            for (int j = 0; j < fWords.length; j++) {
                if (fWords[j] > fQuery) {
                    count = fWords.length - j;
                    break;
                }
            }
            result[i] = count;
        }
        return result;
    }

    private int f(String s) {
        char minChar = 'z' + 1;
        int count = 0;
        for (char c : s.toCharArray()) {
            if (c < minChar) {
                minChar = c;
                count = 1;
            } else if (c == minChar) {
                count++;
            }
        }
        return count;
    }
}