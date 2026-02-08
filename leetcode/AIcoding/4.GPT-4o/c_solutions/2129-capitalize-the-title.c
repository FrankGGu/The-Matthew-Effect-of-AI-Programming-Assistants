char *capitalizeTitle(char *title) {
    char *result = strdup(title);
    int i = 0;
    int wordStart = 0;
    while (result[i]) {
        if (i == 0 || result[i - 1] == ' ') {
            wordStart = i;
        }
        if (result[i] == ' ' || result[i + 1] == '\0') {
            int wordLen = (result[i] == ' ') ? i - wordStart : i - wordStart + 1;
            if (wordLen > 2) {
                result[wordStart] = toupper(result[wordStart]);
            } else {
                result[wordStart] = tolower(result[wordStart]);
            }
            for (int j = 1; j < wordLen; j++) {
                result[wordStart + j] = tolower(result[wordStart + j]);
            }
        }
        i++;
    }
    return result;
}