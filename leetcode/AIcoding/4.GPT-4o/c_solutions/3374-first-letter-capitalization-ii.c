char *capitalizeTitle(char *title) {
    char *ptr = title;
    int wordStart = 0, wordLength = 0;

    while (*ptr) {
        if (*ptr == ' ') {
            if (wordLength > 0) {
                if (wordLength > 2) {
                    title[wordStart] = toupper(title[wordStart]);
                }
                for (int i = 1; i < wordLength; i++) {
                    title[wordStart + i] = tolower(title[wordStart + i]);
                }
                wordLength = 0;
            }
            wordStart++;
        } else {
            if (wordLength == 0) {
                wordStart = ptr - title;
            }
            wordLength++;
        }
        ptr++;
    }

    if (wordLength > 0) {
        if (wordLength > 2) {
            title[wordStart] = toupper(title[wordStart]);
        }
        for (int i = 1; i < wordLength; i++) {
            title[wordStart + i] = tolower(title[wordStart + i]);
        }
    }

    return title;
}