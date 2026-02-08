int countCharacters(char** words, int wordsSize, char* chars) {
    int charCount[26] = {0};
    int total = 0;

    for (int i = 0; chars[i] != '\0'; i++) {
        charCount[chars[i] - 'a']++;
    }

    for (int i = 0; i < wordsSize; i++) {
        int tempCount[26];
        memcpy(tempCount, charCount, sizeof(charCount));
        int valid = 1;

        for (int j = 0; words[i][j] != '\0'; j++) {
            if (tempCount[words[i][j] - 'a'] == 0) {
                valid = 0;
                break;
            }
            tempCount[words[i][j] - 'a']--;
        }

        if (valid) {
            total += strlen(words[i]);
        }
    }

    return total;
}