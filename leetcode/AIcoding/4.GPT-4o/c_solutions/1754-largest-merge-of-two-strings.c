char *largestMerge(char *word1, char *word2) {
    int len1 = strlen(word1), len2 = strlen(word2);
    char *result = (char *)malloc(len1 + len2 + 1);
    int i = 0, j = 0, k = 0;

    while (i < len1 && j < len2) {
        if (strcmp(&word1[i], &word2[j]) > 0) {
            result[k++] = word1[i++];
        } else {
            result[k++] = word2[j++];
        }
    }

    while (i < len1) {
        result[k++] = word1[i++];
    }

    while (j < len2) {
        result[k++] = word2[j++];
    }

    result[k] = '\0';
    return result;
}