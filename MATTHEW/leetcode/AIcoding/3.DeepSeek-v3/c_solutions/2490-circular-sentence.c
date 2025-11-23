bool isCircularSentence(char* sentence) {
    int n = strlen(sentence);
    if (sentence[0] != sentence[n - 1]) {
        return false;
    }

    for (int i = 0; i < n; i++) {
        if (sentence[i] == ' ') {
            if (sentence[i - 1] != sentence[i + 1]) {
                return false;
            }
        }
    }

    return true;
}