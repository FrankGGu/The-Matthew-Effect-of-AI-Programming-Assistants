int canBeTypedWords(char* text, char* brokenLetters) {
    int broken[26] = {0};
    int count = 0;
    int canType = 1;

    for (int i = 0; brokenLetters[i]; i++) {
        broken[brokenLetters[i] - 'a'] = 1;
    }

    for (int i = 0; text[i]; i++) {
        if (text[i] == ' ') {
            if (canType) count++;
            canType = 1;
        } else {
            if (broken[text[i] - 'a']) {
                canType = 0;
            }
        }
    }

    if (canType) count++;

    return count;
}