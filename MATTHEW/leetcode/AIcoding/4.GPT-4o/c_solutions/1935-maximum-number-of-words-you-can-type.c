int canBeTypedWords(char *text, char *brokenLetters) {
    int broken[26] = {0};
    for (int i = 0; brokenLetters[i]; i++) {
        broken[brokenLetters[i] - 'a'] = 1;
    }

    int count = 0;
    char *word = strtok(text, " ");
    while (word) {
        int valid = 1;
        for (int i = 0; word[i]; i++) {
            if (broken[word[i] - 'a']) {
                valid = 0;
                break;
            }
        }
        if (valid) count++;
        word = strtok(NULL, " ");
    }

    return count;
}