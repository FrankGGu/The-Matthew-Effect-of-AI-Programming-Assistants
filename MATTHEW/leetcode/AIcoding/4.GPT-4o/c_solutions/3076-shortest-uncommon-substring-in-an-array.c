#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int is_substring(char* substring, char** words, int wordsSize) {
    for (int i = 0; i < wordsSize; i++) {
        if (strstr(words[i], substring) != NULL) {
            return 0;
        }
    }
    return 1;
}

char* shortestUncommonSubstring(char** words, int wordsSize) {
    int minLen = 100; // arbitrary large number
    char* result = NULL;

    for (int i = 0; i < wordsSize; i++) {
        for (int j = 1; j <= strlen(words[i]); j++) {
            for (int k = 0; k <= strlen(words[i]) - j; k++) {
                char* substring = (char*)malloc((j + 1) * sizeof(char));
                strncpy(substring, &words[i][k], j);
                substring[j] = '\0';

                if (is_substring(substring, words, wordsSize)) {
                    if (j < minLen) {
                        minLen = j;
                        result = substring;
                    } else {
                        free(substring);
                    }
                } else {
                    free(substring);
                }
            }
        }
    }

    return result ? result : "";
}