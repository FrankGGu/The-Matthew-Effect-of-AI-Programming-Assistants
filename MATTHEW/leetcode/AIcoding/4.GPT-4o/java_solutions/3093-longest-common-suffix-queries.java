class SuffixArray {
    private String[] words;
    private int[][] suffixArray;

    public SuffixArray(String[] words) {
        this.words = words;
        this.suffixArray = new int[words.length][];
        for (int i = 0; i < words.length; i++) {
            suffixArray[i] = buildSuffixArray(words[i]);
        }
    }

    private int[] buildSuffixArray(String word) {
        int n = word.length();
        int[] suffixes = new int[n];
        for (int i = 0; i < n; i++) {
            suffixes[i] = i;
        }
        Arrays.sort(suffixes, (a, b) -> word.substring(a).compareTo(word.substring(b)));
        return suffixes;
    }

    public int longestCommonSuffix(int index1, int index2) {
        String word1 = words[index1];
        String word2 = words[index2];
        int minLength = Math.min(word1.length(), word2.length());

        int length = 0;
        for (int i = 1; i <= minLength; i++) {
            if (word1.charAt(word1.length() - i) == word2.charAt(word2.length() - i)) {
                length++;
            } else {
                break;
            }
        }
        return length;
    }
}

class LongestCommonSuffixQueries {
    private SuffixArray suffixArray;

    public LongestCommonSuffixQueries(String[] words) {
        suffixArray = new SuffixArray(words);
    }

    public int longestCommonSuffix(int index1, int index2) {
        return suffixArray.longestCommonSuffix(index1, index2);
    }
}