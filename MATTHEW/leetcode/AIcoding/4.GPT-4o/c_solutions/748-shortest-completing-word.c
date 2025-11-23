char *shortestCompletingWord(char *licensePlate, char **words, int wordsSize) {
    int count[26] = {0}, minLen = 0;
    char *result = NULL;

    for (char *p = licensePlate; *p; p++) {
        if (*p >= 'a' && *p <= 'z') {
            count[*p - 'a']++;
        } else if (*p >= 'A' && *p <= 'Z') {
            count[*p - 'A']++;
        }
    }

    for (int i = 0; i < wordsSize; i++) {
        int tempCount[26] = {0};
        int j;
        for (j = 0; words[i][j]; j++) {
            tempCount[words[i][j] - 'a']++;
        }

        int valid = 1;
        for (int k = 0; k < 26; k++) {
            if (count[k] > tempCount[k]) {
                valid = 0;
                break;
            }
        }

        if (valid) {
            if (result == NULL || j < minLen) {
                result = words[i];
                minLen = j;
            }
        }
    }

    return result;
}