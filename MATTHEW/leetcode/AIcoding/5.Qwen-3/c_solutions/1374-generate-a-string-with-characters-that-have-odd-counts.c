#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* generateTheString(int n) {
    char* result = (char*)malloc((n + 1) * sizeof(char));
    if (n % 2 == 0) {
        strcpy(result, "a");
        for (int i = 1; i < n; i++) {
            result[i] = 'b';
        }
    } else {
        for (int i = 0; i < n; i++) {
            result[i] = 'a';
        }
    }
    result[n] = '\0';
    return result;
}