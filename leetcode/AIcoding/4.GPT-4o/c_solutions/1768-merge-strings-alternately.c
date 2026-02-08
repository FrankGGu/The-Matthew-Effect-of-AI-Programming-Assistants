char *mergeAlternately(char *word1, char *word2) {
    int i = 0, j = 0, k = 0;
    int len1 = strlen(word1), len2 = strlen(word2);
    char *result = malloc(len1 + len2 + 1);

    while (i < len1 || j < len2) {
        if (i < len1) result[k++] = word1[i++];
        if (j < len2) result[k++] = word2[j++];
    }
    result[k] = '\0';
    return result;
}