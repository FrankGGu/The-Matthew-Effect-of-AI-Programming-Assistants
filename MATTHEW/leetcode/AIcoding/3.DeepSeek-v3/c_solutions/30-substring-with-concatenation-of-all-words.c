/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* findSubstring(char * s, char ** words, int wordsSize, int* returnSize){
    if (wordsSize == 0 || strlen(s) == 0) {
        *returnSize = 0;
        return NULL;
    }

    int wordLen = strlen(words[0]);
    int totalLen = wordLen * wordsSize;
    int sLen = strlen(s);

    if (sLen < totalLen) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(sLen * sizeof(int));
    *returnSize = 0;

    // Count frequency of each word
    int wordCountSize = 1000;
    char** wordCount = (char**)malloc(wordCountSize * sizeof(char*));
    int* count = (int*)malloc(wordCountSize * sizeof(int));
    int uniqueWords = 0;

    for (int i = 0; i < wordsSize; i++) {
        int found = 0;
        for (int j = 0; j < uniqueWords; j++) {
            if (strcmp(wordCount[j], words[i]) == 0) {
                count[j]++;
                found = 1;
                break;
            }
        }
        if (!found) {
            wordCount[uniqueWords] = words[i];
            count[uniqueWords] = 1;
            uniqueWords++;
        }
    }

    for (int i = 0; i <= sLen - totalLen; i++) {
        int* seen = (int*)malloc(uniqueWords * sizeof(int));
        for (int j = 0; j < uniqueWords; j++) {
            seen[j] = 0;
        }

        int valid = 1;
        for (int j = 0; j < wordsSize; j++) {
            int start = i + j * wordLen;
            char* currentWord = (char*)malloc((wordLen + 1) * sizeof(char));
            strncpy(currentWord, s + start, wordLen);
            currentWord[wordLen] = '\0';

            int found = 0;
            for (int k = 0; k < uniqueWords; k++) {
                if (strcmp(wordCount[k], currentWord) == 0) {
                    seen[k]++;
                    if (seen[k] > count[k]) {
                        valid = 0;
                    }
                    found = 1;
                    break;
                }
            }
            free(currentWord);

            if (!found) {
                valid = 0;
                break;
            }

            if (!valid) {
                break;
            }
        }

        if (valid) {
            // Check if all counts match exactly
            int exactMatch = 1;
            for (int k = 0; k < uniqueWords; k++) {
                if (seen[k] != count[k]) {
                    exactMatch = 0;
                    break;
                }
            }
            if (exactMatch) {
                result[*returnSize] = i;
                (*returnSize)++;
            }
        }

        free(seen);
    }

    free(wordCount);
    free(count);

    return result;
}