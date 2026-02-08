#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* addDigits(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int index = 0;

    for (int i = 0; i < len; i += 2) {
        int sum = 0;
        if (i + 1 < len) {
            sum += s[i] - '0';
            sum += s[i + 1] - '0';
        } else {
            sum += s[i] - '0';
        }
        result[index++] = sum + '0';
    }
    result[index] = '\0';
    return result;
}

char* digitSum(char* s, int k) {
    char* current = strdup(s);
    while (strlen(current) > k) {
        char* next = addDigits(current);
        free(current);
        current = next;
    }
    return current;
}