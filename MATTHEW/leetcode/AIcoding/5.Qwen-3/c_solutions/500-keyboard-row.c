#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** findWords(char** words, int wordsSize, int* returnSize) {
    char* row1 = "qwertyuiop";
    char* row2 = "asdfghjkl";
    char* row3 = "zxcvbnm";

    char** result = (char**)malloc(wordsSize * sizeof(char*));
    int count = 0;

    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        int inRow1 = 1;
        int inRow2 = 1;
        int inRow3 = 1;

        for (int j = 0; word[j] != '\0'; j++) {
            char c = tolower(word[j]);
            if (strchr(row1, c) == NULL) inRow1 = 0;
            if (strchr(row2, c) == NULL) inRow2 = 0;
            if (strchr(row3, c) == NULL) inRow3 = 0;
        }

        if (inRow1 || inRow2 || inRow3) {
            result[count++] = strdup(word);
        }
    }

    *returnSize = count;
    return result;
}