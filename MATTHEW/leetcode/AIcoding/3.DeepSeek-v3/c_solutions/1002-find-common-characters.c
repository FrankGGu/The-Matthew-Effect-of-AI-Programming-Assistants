/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
char** commonChars(char** words, int wordsSize, int* returnSize) {
    int minFreq[26] = {0};
    for (int i = 0; i < 26; i++) {
        minFreq[i] = 100;
    }

    for (int i = 0; i < wordsSize; i++) {
        int charCount[26] = {0};
        char* word = words[i];
        int len = strlen(word);
        for (int j = 0; j < len; j++) {
            charCount[word[j] - 'a']++;
        }
        for (int k = 0; k < 26; k++) {
            if (charCount[k] < minFreq[k]) {
                minFreq[k] = charCount[k];
            }
        }
    }

    int total = 0;
    for (int i = 0; i < 26; i++) {
        total += minFreq[i];
    }

    char** result = (char**)malloc(total * sizeof(char*));
    int index = 0;
    for (int i = 0; i < 26; i++) {
        for (int j = 0; j < minFreq[i]; j++) {
            result[index] = (char*)malloc(2 * sizeof(char));
            result[index][0] = 'a' + i;
            result[index][1] = '\0';
            index++;
        }
    }

    *returnSize = total;
    return result;
}