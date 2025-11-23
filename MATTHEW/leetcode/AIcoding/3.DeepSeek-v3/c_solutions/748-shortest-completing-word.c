#include <string.h>
#include <ctype.h>

char* shortestCompletingWord(char* licensePlate, char** words, int wordsSize) {
    int plateCount[26] = {0};
    int len = strlen(licensePlate);

    for (int i = 0; i < len; i++) {
        if (isalpha(licensePlate[i])) {
            plateCount[tolower(licensePlate[i]) - 'a']++;
        }
    }

    char* result = NULL;
    int minLen = 1001;

    for (int i = 0; i < wordsSize; i++) {
        int wordCount[26] = {0};
        int wordLen = strlen(words[i]);

        for (int j = 0; j < wordLen; j++) {
            wordCount[tolower(words[i][j]) - 'a']++;
        }

        int valid = 1;
        for (int k = 0; k < 26; k++) {
            if (wordCount[k] < plateCount[k]) {
                valid = 0;
                break;
            }
        }

        if (valid && wordLen < minLen) {
            minLen = wordLen;
            result = words[i];
        }
    }

    return result;
}