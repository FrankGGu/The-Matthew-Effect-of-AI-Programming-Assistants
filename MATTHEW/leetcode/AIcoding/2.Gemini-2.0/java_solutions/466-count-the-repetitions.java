class Solution {
    public int getMaxRepetitions(String s1, int n1, String s2, int n2) {
        int len1 = s1.length();
        int len2 = s2.length();

        int[] repeatCount = new int[len2 + 1];
        int[] nextIndex = new int[len2 + 1];

        int j = 0, count = 0;
        for (int k = 1; k <= n1; k++) {
            for (int i = 0; i < len1; i++) {
                if (s1.charAt(i) == s2.charAt(j)) {
                    j++;
                    if (j == len2) {
                        count++;
                        j = 0;
                    }
                }
            }
            repeatCount[k] = count;
            nextIndex[k] = j;

            for (int start = 1; start < k; start++) {
                if (nextIndex[start] == j) {
                    int prefixCount = repeatCount[start - 1];
                    int patternCount = (repeatCount[k] - repeatCount[start - 1]) * ((n1 - start) / (k - start));
                    int suffixCount = repeatCount[start + (n1 - start) % (k - start)] - repeatCount[start - 1];
                    return (prefixCount + patternCount + suffixCount) / n2;
                }
            }
        }

        return repeatCount[n1] / n2;
    }
}