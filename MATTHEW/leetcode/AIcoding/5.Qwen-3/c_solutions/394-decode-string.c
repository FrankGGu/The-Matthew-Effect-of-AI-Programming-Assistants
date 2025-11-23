#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* decodeString(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc(sizeof(char) * (len + 1));
    int resultIndex = 0;
    char* numStack = (char*)malloc(sizeof(char) * (len + 1));
    int numTop = -1;
    char* strStack = (char*)malloc(sizeof(char) * (len + 1));
    int strTop = -1;

    for (int i = 0; i < len; i++) {
        if (s[i] >= '0' && s[i] <= '9') {
            int j = i;
            while (j < len && s[j] >= '0' && s[j] <= '9') {
                j++;
            }
            int numLen = j - i;
            char* num = (char*)malloc(numLen + 1);
            strncpy(num, s + i, numLen);
            num[numLen] = '\0';
            numStack[++numTop] = num;
            i = j - 1;
        } else if (s[i] == '[') {
            strStack[++strTop] = (char*)malloc(sizeof(char) * (len + 1));
            strcpy(strStack[strTop], result);
            resultIndex = 0;
            result = (char*)malloc(sizeof(char) * (len + 1));
        } else if (s[i] == ']') {
            char* num = numStack[numTop--];
            int numVal = atoi(num);
            free(num);
            char* prevStr = strStack[strTop--];
            int prevLen = strlen(prevStr);
            int newLen = prevLen + strlen(result) * numVal;
            char* newResult = (char*)malloc(sizeof(char) * (newLen + 1));
            strcpy(newResult, prevStr);
            for (int k = 0; k < numVal; k++) {
                strcat(newResult, result);
            }
            free(result);
            result = newResult;
            resultIndex = strlen(result);
        } else {
            result[resultIndex++] = s[i];
            result[resultIndex] = '\0';
        }
    }

    free(numStack);
    for (int i = 0; i <= strTop; i++) {
        free(strStack[i]);
    }
    free(strStack);

    return result;
}