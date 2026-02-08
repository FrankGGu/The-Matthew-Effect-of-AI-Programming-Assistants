char* convert(char* s, int numRows) {
    if (numRows == 1) return s;

    int len = strlen(s);
    char* result = (char*)malloc(len + 1);
    int index = 0;

    for (int row = 0; row < numRows; row++) {
        int step1 = (numRows - row - 1) * 2;
        int step2 = row * 2;

        int pos = row;
        while (pos < len) {
            if (step1 > 0) {
                result[index++] = s[pos];
                pos += step1;
            }
            if (pos < len && step2 > 0) {
                result[index++] = s[pos];
                pos += step2;
            }
        }
    }

    result[len] = '\0';
    return result;
}