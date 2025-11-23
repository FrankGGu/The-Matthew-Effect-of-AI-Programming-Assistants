#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* countAndSay(int n) {
    if (n == 1) {
        char* result = (char*)malloc(2 * sizeof(char));
        strcpy(result, "1");
        return result;
    }

    char* prev = countAndSay(n - 1);
    char* result = (char*)malloc(sizeof(char) * 1000);
    int index = 0;

    int i = 0;
    while (prev[i] != '\0') {
        char currentChar = prev[i];
        int count = 0;
        while (prev[i] == currentChar) {
            i++;
            count++;
        }
        sprintf(result + index, "%d%c", count, currentChar);
        index += strlen(result + index);
    }

    free(prev);
    return result;
}