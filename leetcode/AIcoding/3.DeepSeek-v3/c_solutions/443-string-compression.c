int compress(char* chars, int charsSize) {
    int write = 0, read = 0;

    while (read < charsSize) {
        char currentChar = chars[read];
        int count = 0;

        while (read < charsSize && chars[read] == currentChar) {
            read++;
            count++;
        }

        chars[write++] = currentChar;

        if (count > 1) {
            char countStr[5];
            int len = sprintf(countStr, "%d", count);
            for (int i = 0; i < len; i++) {
                chars[write++] = countStr[i];
            }
        }
    }

    return write;
}