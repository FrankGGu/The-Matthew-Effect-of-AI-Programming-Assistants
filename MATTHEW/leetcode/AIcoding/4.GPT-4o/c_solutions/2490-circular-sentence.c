bool isCircularSentence(char * sentence) {
    int len = strlen(sentence);
    if (sentence[len - 1] != ' ' && sentence[len - 1] != sentence[0]) {
        return false;
    }
    for (int i = 0; i < len; i++) {
        if (sentence[i] == ' ' && sentence[i - 1] != sentence[i + 1]) {
            return false;
        }
    }
    return true;
}