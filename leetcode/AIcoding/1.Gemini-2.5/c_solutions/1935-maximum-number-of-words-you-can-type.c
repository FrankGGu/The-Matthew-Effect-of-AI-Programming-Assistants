int canBeTypedWords(char * text, char * brokenLetters){
    int broken[26] = {0};
    for (int i = 0; brokenLetters[i] != '\0'; i++) {
        broken[brokenLetters[i] - 'a'] = 1;
    }

    int count = 0;
    int typable = 1;
    for (int i = 0; text[i] != '\0'; i++) {
        if (text[i] == ' ') {
            if (typable) {
                count++;
            }
            typable = 1;
        } else {
            if (broken[text[i] - 'a']) {
                typable = 0;
            }
        }
    }
    if (typable) {
        count++;
    }

    return count;
}