#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxLength(char ** arr, int arrSize){
    int maxLen = 0;

    void backtrack(int index, char* currentString) {
        if (index == arrSize) {
            int len = strlen(currentString);
            maxLen = (len > maxLen) ? len : maxLen;
            return;
        }

        char nextString[1001] = "";
        strcpy(nextString, currentString);
        strcat(nextString, arr[index]);

        bool unique = true;
        int charCount[26] = {0};
        for (int i = 0; nextString[i] != '\0'; i++) {
            if (charCount[nextString[i] - 'a'] > 0) {
                unique = false;
                break;
            }
            charCount[nextString[i] - 'a']++;
        }

        if (unique) {
            backtrack(index + 1, nextString);
        }

        backtrack(index + 1, currentString);
    }

    char initialString[1] = "";
    backtrack(0, initialString);

    return maxLen;
}