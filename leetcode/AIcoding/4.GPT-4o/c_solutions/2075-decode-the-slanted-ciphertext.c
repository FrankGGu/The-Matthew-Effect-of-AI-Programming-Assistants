char * decodeCiphertext(char * encodedText, int rows) {
    int len = strlen(encodedText);
    if (len == 0 || rows == 0) return "";
    int cols = (len + rows - 1) / rows;
    char *decoded = (char *)malloc(len + 1);
    int index = 0;

    for (int c = 0; c < cols; c++) {
        for (int r = 0; r < rows; r++) {
            int pos = r + c + r * cols;
            if (pos < len) {
                decoded[index++] = encodedText[pos];
            }
        }
    }
    decoded[index] = '\0';

    while (index > 0 && decoded[index - 1] == ' ') {
        index--;
    }
    decoded[index] = '\0';

    return decoded;
}