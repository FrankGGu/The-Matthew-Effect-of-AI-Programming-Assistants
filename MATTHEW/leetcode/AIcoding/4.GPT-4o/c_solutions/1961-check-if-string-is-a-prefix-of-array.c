bool isPrefixString(char * s, char ** words, int wordsSize) {
    int sLen = strlen(s);
    int index = 0;

    for (int i = 0; i < wordsSize; i++) {
        int wordLen = strlen(words[i]);
        if (index + wordLen > sLen) {
            return false;
        }
        for (int j = 0; j < wordLen; j++) {
            if (s[index + j] != words[i][j]) {
                return false;
            }
        }
        index += wordLen;
        if (index == sLen) {
            return true;
        }
    }

    return index == sLen;
}