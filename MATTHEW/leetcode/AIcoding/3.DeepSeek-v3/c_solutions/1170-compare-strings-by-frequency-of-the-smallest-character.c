/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int f(char* s) {
    int count[26] = {0};
    int min_char = 26;

    for (int i = 0; s[i] != '\0'; i++) {
        int idx = s[i] - 'a';
        count[idx]++;
        if (idx < min_char) {
            min_char = idx;
        }
    }

    return count[min_char];
}

int* numSmallerByFrequency(char** queries, int queriesSize, char** words, int wordsSize, int* returnSize) {
    *returnSize = queriesSize;
    int* result = (int*)malloc(queriesSize * sizeof(int));
    int* wordFreq = (int*)malloc(wordsSize * sizeof(int));

    for (int i = 0; i < wordsSize; i++) {
        wordFreq[i] = f(words[i]);
    }

    for (int i = 0; i < queriesSize; i++) {
        int queryFreq = f(queries[i]);
        int count = 0;
        for (int j = 0; j < wordsSize; j++) {
            if (queryFreq < wordFreq[j]) {
                count++;
            }
        }
        result[i] = count;
    }

    free(wordFreq);
    return result;
}