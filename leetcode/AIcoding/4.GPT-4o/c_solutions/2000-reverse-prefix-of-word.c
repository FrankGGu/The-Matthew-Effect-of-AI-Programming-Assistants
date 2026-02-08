char *reversePrefix(char *word, char ch) {
    int len = strlen(word);
    char *result = malloc(len + 1);
    int i = 0;

    while (i < len && word[i] != ch) {
        result[i] = word[i];
        i++;
    }

    if (i < len) {
        result[i] = word[i];
        i++;
    }

    for (int j = i - 1; j >= 0; j--) {
        result[len - i + j] = result[j];
    }

    for (int k = i; k < len; k++) {
        result[k] = word[k];
    }

    result[len] = '\0';
    return result;
}