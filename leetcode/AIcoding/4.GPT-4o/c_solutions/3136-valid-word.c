bool isValidWord(char * word, char * allowedChars) {
    int allowed[26] = {0};
    for (int i = 0; allowedChars[i] != '\0'; i++) {
        allowed[allowedChars[i] - 'a'] = 1;
    }
    for (int i = 0; word[i] != '\0'; i++) {
        if (!allowed[word[i] - 'a']) {
            return false;
        }
    }
    return true;
}