int isPrefixOfWord(char* sentence, char* searchWord) {
    int wordIndex = 1;
    int i = 0;

    while (sentence[i]) {
        int j = 0;
        while (sentence[i] == searchWord[j] && sentence[i] != ' ' && searchWord[j]) {
            i++;
            j++;
        }

        if (searchWord[j] == '\0') {
            return wordIndex;
        }

        while (sentence[i] && sentence[i] != ' ') {
            i++;
        }

        if (sentence[i] == ' ') {
            i++;
        }

        wordIndex++;
    }

    return -1;
}