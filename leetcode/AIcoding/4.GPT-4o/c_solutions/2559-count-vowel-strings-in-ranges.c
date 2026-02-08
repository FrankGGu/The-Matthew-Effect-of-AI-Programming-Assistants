int isVowel(char c) {
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
}

int countVowelStrings(char **words, int wordsSize, int** queries, int queriesSize, int* queriesColSize) {
    int *prefixCount = (int *)malloc((wordsSize + 1) * sizeof(int));
    prefixCount[0] = 0;

    for (int i = 0; i < wordsSize; i++) {
        prefixCount[i + 1] = prefixCount[i] + (isVowel(words[i][0]) && isVowel(words[i][strlen(words[i]) - 1]) ? 1 : 0);
    }

    int *result = (int *)malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        int left = queries[i][0];
        int right = queries[i][1];
        result[i] = prefixCount[right + 1] - prefixCount[left];
    }

    free(prefixCount);
    return result;
}