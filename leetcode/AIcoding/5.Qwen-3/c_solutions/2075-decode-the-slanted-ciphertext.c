#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* decodeCiphertext(char* s, int k) {
    int n = strlen(s);
    char* result = (char*)malloc(n + 1);
    int idx = 0;

    for (int i = 0; i < k; i++) {
        for (int j = i; j < n; j += k) {
            result[idx++] = s[j];
        }
    }

    result[idx] = '\0';
    return result;
}