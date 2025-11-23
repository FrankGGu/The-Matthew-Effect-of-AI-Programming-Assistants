bool arrayStringsAreEqual(char **word1, int word1Size, char **word2, int word2Size) {
    char *s1 = (char *)malloc(1000 * sizeof(char));
    char *s2 = (char *)malloc(1000 * sizeof(char));
    s1[0] = '\0';
    s2[0] = '\0';

    for (int i = 0; i < word1Size; i++) {
        strcat(s1, word1[i]);
    }
    for (int i = 0; i < word2Size; i++) {
        strcat(s2, word2[i]);
    }

    bool result = strcmp(s1, s2) == 0;

    free(s1);
    free(s2);

    return result;
}