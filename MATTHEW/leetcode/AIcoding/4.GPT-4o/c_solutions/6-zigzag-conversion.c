char *convert(char *s, int numRows) {
    if (numRows == 1 || numRows >= strlen(s)) return s;

    char *result = malloc(strlen(s) + 1);
    int index = 0, len = strlen(s);
    int cycleLen = 2 * numRows - 2;

    for (int row = 0; row < numRows; row++) {
        for (int j = 0; j + row < len; j += cycleLen) {
            result[index++] = s[j + row];
            if (row > 0 && row < numRows - 1 && j + cycleLen - row < len) {
                result[index++] = s[j + cycleLen - row];
            }
        }
    }

    result[index] = '\0';
    return result;
}