#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int numberDifferentIntegers(const char* word) {
    int len = strlen(word);
    int count = 0;
    int inNumber = 0;
    int leadingZero = 0;
    char* numStr = (char*)malloc(len + 1);
    int index = 0;

    for (int i = 0; i <= len; i++) {
        if (isdigit(word[i])) {
            if (i == 0 || !isdigit(word[i - 1])) {
                inNumber = 1;
                index = 0;
                if (word[i] == '0' && (i + 1 == len || !isdigit(word[i + 1]))) {
                    leadingZero = 1;
                } else {
                    leadingZero = 0;
                }
            }
            numStr[index++] = word[i];
        } else if (inNumber) {
            inNumber = 0;
            numStr[index] = '\0';
            if (leadingZero && index > 1) {
                leadingZero = 0;
            } else {
                count++;
            }
            index = 0;
        }
    }

    free(numStr);
    return count;
}