int mostWordsInSentence(char ** sentences, int sentencesSize) {
    int maxWords = 0;
    for (int i = 0; i < sentencesSize; i++) {
        int wordCount = 1;
        for (char *p = sentences[i]; *p; p++) {
            if (*p == ' ') {
                wordCount++;
            }
        }
        if (wordCount > maxWords) {
            maxWords = wordCount;
        }
    }
    return maxWords;
}