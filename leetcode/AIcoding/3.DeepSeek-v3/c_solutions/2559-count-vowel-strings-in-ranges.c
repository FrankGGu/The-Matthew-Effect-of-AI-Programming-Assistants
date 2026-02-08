/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* vowelStrings(char** words, int wordsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* prefix = malloc((wordsSize + 1) * sizeof(int));
    prefix[0] = 0;

    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        int len = strlen(word);
        char first = word[0];
        char last = word[len - 1];

        int isVowelFirst = (first == 'a' || first == 'e' || first == 'i' || first == 'o' || first == 'u');
        int isVowelLast = (last == 'a' || last == 'e' || last == 'i' || last == 'o' || last == 'u');

        prefix[i + 1] = prefix[i] + (isVowelFirst && isVowelLast ? 1 : 0);
    }

    int* result = malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int left = queries[i][0];
        int right = queries[i][1];
        result[i] = prefix[right + 1] - prefix[left];
    }

    free(prefix);
    return result;
}