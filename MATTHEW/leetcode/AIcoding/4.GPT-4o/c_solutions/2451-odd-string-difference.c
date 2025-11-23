char* oddString(char** words, int wordsSize) {
    int* diff = (int*)malloc(sizeof(int) * wordsSize);
    for (int i = 0; i < wordsSize; i++) {
        for (int j = 1; j < strlen(words[i]); j++) {
            diff[i] += (words[i][j] - words[i][j - 1]);
        }
    }

    int oddIndex = -1;
    for (int i = 0; i < wordsSize; i++) {
        int count = 0;
        for (int j = 0; j < wordsSize; j++) {
            if (diff[i] == diff[j]) {
                count++;
            }
        }
        if (count == 1) {
            oddIndex = i;
            break;
        }
    }

    char* result = (char*)malloc(strlen(words[oddIndex]) + 1);
    strcpy(result, words[oddIndex]);
    free(diff);
    return result;
}