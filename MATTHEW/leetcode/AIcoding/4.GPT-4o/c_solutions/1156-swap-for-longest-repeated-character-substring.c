int maxRepOpt1(char * text) {
    int count[26] = {0};
    int n = strlen(text);
    for (int i = 0; i < n; i++) {
        count[text[i] - 'a']++;
    }

    int maxLength = 0;
    for (int i = 0; i < n; ) {
        char currentChar = text[i];
        int j = i;
        while (j < n && text[j] == currentChar) {
            j++;
        }

        int length = j - i;
        int totalCount = count[currentChar - 'a'];

        if (length < totalCount) {
            maxLength = fmax(maxLength, length + 1);
        } else {
            maxLength = fmax(maxLength, length);
            if (length > 1 && j < n && text[j] != currentChar) {
                maxLength = fmax(maxLength, length + 1);
            }
        }

        i = j;
    }

    return maxLength;
}