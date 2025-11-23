#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* minString(char* s, int* cost, int n) {
    char* result = (char*)malloc((n + 1) * sizeof(char));
    int index = 0;
    for (int i = 0; i < n; i++) {
        if (i == 0 || s[i] != s[i - 1]) {
            result[index++] = s[i];
        } else {
            if (cost[i] > cost[i - 1]) {
                result[index - 1] = s[i];
            }
        }
    }
    result[index] = '\0';
    return result;
}