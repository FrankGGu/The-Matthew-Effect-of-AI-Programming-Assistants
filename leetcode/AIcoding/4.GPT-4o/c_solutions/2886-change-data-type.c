char * convertToTitle(int columnNumber) {
    char *result = (char *)malloc(100);
    int index = 0;

    while (columnNumber > 0) {
        columnNumber--; // Adjust index to 0-based
        result[index++] = 'A' + (columnNumber % 26);
        columnNumber /= 26;
    }

    result[index] = '\0';

    // Reverse the result
    for (int i = 0; i < index / 2; i++) {
        char temp = result[i];
        result[i] = result[index - 1 - i];
        result[index - 1 - i] = temp;
    }

    return result;
}