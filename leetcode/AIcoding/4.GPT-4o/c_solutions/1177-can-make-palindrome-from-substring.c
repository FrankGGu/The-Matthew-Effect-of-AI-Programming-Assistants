bool canMakePaliQueries(char *s, int sSize, int **queries, int queriesSize, int *queriesColSize) {
    int count[100001][26] = {0};
    for (int i = 0; i < sSize; i++) {
        for (int j = 0; j < 26; j++) {
            count[i + 1][j] = count[i][j];
        }
        count[i + 1][s[i] - 'a']++;
    }

    bool *result = (bool *)malloc(queriesSize * sizeof(bool));
    for (int i = 0; i < queriesSize; i++) {
        int left = queries[i][0], right = queries[i][1], k = queries[i][2];
        int oddCount = 0;
        for (int j = 0; j < 26; j++) {
            if ((count[right + 1][j] - count[left][j]) % 2 != 0) {
                oddCount++;
            }
        }
        result[i] = oddCount / 2 <= k;
    }

    return result;
}