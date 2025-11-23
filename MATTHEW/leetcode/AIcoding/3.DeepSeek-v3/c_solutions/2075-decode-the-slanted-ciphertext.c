char* decodeCiphertext(char* encodedText, int rows) {
    int len = strlen(encodedText);
    if (len == 0 || rows == 0) {
        char* result = malloc(1);
        result[0] = '\0';
        return result;
    }

    int cols = len / rows;
    int maxLen = len + 1;
    char* result = malloc(maxLen);
    int idx = 0;

    for (int c = 0; c < cols; c++) {
        for (int r = 0; r < rows; r++) {
            int pos = r * cols + (c + r);
            if (pos < len) {
                result[idx++] = encodedText[pos];
            }
        }
    }

    while (idx > 0 && result[idx - 1] == ' ') {
        idx--;
    }

    result[idx] = '\0';
    return result;
}