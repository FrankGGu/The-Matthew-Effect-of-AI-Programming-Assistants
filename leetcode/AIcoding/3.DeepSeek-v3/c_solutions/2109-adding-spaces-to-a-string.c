char* addSpaces(char* s, int* spaces, int spacesSize) {
    int n = strlen(s);
    int newLen = n + spacesSize;
    char* result = (char*)malloc((newLen + 1) * sizeof(char));

    int sIndex = 0;
    int spaceIndex = 0;
    int resIndex = 0;

    for (int i = 0; i < n; i++) {
        if (spaceIndex < spacesSize && i == spaces[spaceIndex]) {
            result[resIndex++] = ' ';
            spaceIndex++;
        }
        result[resIndex++] = s[i];
    }

    result[newLen] = '\0';
    return result;
}