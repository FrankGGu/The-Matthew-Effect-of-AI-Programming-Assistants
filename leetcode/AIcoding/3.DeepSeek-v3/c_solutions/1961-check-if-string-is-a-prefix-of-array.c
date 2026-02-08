bool isPrefixString(char* s, char** words, int wordsSize) {
    int len = 0;
    int s_len = strlen(s);

    for (int i = 0; i < wordsSize; i++) {
        int word_len = strlen(words[i]);
        if (len + word_len > s_len) {
            return false;
        }
        if (strncmp(s + len, words[i], word_len) != 0) {
            return false;
        }
        len += word_len;
        if (len == s_len) {
            return true;
        }
    }

    return false;
}