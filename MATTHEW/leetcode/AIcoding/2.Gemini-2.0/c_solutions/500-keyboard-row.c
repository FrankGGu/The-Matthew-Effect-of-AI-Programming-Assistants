#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* keyboardRows[] = {"qwertyuiop", "asdfghjkl", "zxcvbnm"};

bool isInRow(char c, int row) {
    char* rowStr = keyboardRows[row];
    int len = strlen(rowStr);
    for (int i = 0; i < len; i++) {
        if (rowStr[i] == c) {
            return true;
        }
    }
    return false;
}

char** findWords(char** words, int wordsSize, int* returnSize) {
    char** result = (char**)malloc(wordsSize * sizeof(char*));
    *returnSize = 0;

    for (int i = 0; i < wordsSize; i++) {
        char* word = words[i];
        int wordLen = strlen(word);
        char firstChar = tolower(word[0]);

        int row = -1;
        for (int j = 0; j < 3; j++) {
            if (isInRow(firstChar, j)) {
                row = j;
                break;
            }
        }

        if (row == -1) continue;

        bool valid = true;
        for (int k = 1; k < wordLen; k++) {
            char currentChar = tolower(word[k]);
            if (!isInRow(currentChar, row)) {
                valid = false;
                break;
            }
        }

        if (valid) {
            result[*returnSize] = (char*)malloc((wordLen + 1) * sizeof(char));
            strcpy(result[*returnSize], word);
            (*returnSize)++;
        }
    }

    return result;
}