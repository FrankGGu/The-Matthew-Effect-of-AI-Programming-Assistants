int getMaxRepetitions(char* s1, int n1, char* s2, int n2) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);

    int* repeatCount = (int*)malloc((len2 + 1) * sizeof(int));
    int* nextIndex = (int*)malloc((len2 + 1) * sizeof(int));
    memset(repeatCount, 0, (len2 + 1) * sizeof(int));
    memset(nextIndex, 0, (len2 + 1) * sizeof(int));

    int j = 0, cnt = 0;
    for (int k = 1; k <= n1; k++) {
        for (int i = 0; i < len1; i++) {
            if (s1[i] == s2[j]) {
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
                int patternCount = (n1 - start) / (k - start) * (repeatCount[k] - repeatCount[start]);
                int suffixCount = repeatCount[start + (n1 - start) % (k - start)] - repeatCount[start];
                free(repeatCount);
                free(nextIndex);
                return (prefixCount + patternCount + suffixCount) / n2;
            }
        }
    }

    int result = repeatCount[n1] / n2;
    free(repeatCount);
    free(nextIndex);
    return result;
}