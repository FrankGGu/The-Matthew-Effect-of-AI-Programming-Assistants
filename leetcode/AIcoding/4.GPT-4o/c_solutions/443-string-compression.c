int compress(char* chars, int charsSize) {
    int writeIndex = 0, readIndex = 0;

    while (readIndex < charsSize) {
        char currentChar = chars[readIndex];
        int count = 0;

        while (readIndex < charsSize && chars[readIndex] == currentChar) {
            readIndex++;
            count++;
        }

        chars[writeIndex++] = currentChar;
        if (count > 1) {
            char countStr[10];
            int len = sprintf(countStr, "%d", count);
            for (int i = 0; i < len; i++) {
                chars[writeIndex++] = countStr[i];
            }
        }
    }

    return writeIndex;
}