char *addSpaces(char *s, int* spaces, int spacesSize) {
    int len = strlen(s);
    int totalSpaces = spacesSize;
    int newLen = len + totalSpaces;
    char *result = (char *)malloc((newLen + 1) * sizeof(char));
    int j = 0, k = 0;

    for (int i = 0; i < newLen; i++) {
        if (j < totalSpaces && i == spaces[j]) {
            result[i] = ' ';
            j++;
        } else {
            result[i] = s[k++];
        }
    }
    result[newLen] = '\0';
    return result;
}