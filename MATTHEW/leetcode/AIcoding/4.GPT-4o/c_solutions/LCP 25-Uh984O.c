int canBeTypedWords(char *text, char *brokenLetters) {
    int count = 0;
    char *word = strtok(text, " ");

    while (word != NULL) {
        int isBroken = 0;
        for (int i = 0; brokenLetters[i] != '\0'; i++) {
            if (strchr(word, brokenLetters[i]) != NULL) {
                isBroken = 1;
                break;
            }
        }
        if (!isBroken) {
            count++;
        }
        word = strtok(NULL, " ");
    }

    return count;
}