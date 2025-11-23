class Solution {
    public int getMaxRepetitions(String s1, int n1, String s2, int n2) {
        int len1 = s1.length(), len2 = s2.length();
        int[] repeatCount = new int[len2 + 1];
        int[] nextIndex = new int[len2 + 1];
        int j = 0, cnt = 0;
        for (int k = 1; k <= n1; k++) {
            for (int i = 0; i < len1; i++) {
                if (s1.charAt(i) == s2.charAt(j)) {
                    j++;
                    if (j == len2) {
                        j = 0;
                        cnt++;
                    }
                }
            }
            repeatCount[k] = cnt;
            nextIndex[k] = j;
            for (int start = 0; start < k; start++) {
                if (nextIndex[start] == j) {
                    int prefixCount = repeatCount[start];
                    int patternCount = (repeatCount[k] - repeatCount[start]) * ((n1 - start) / (k - start));
                    int suffixCount = repeatCount[start + (n1 - start) % (k - start)] - repeatCount[start];
                    return (prefixCount + patternCount + suffixCount) / n2;
                }
            }
        }
        return repeatCount[n1] / n2;
    }
}