#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* dynamicPassword(char* password, int* key, int keySize) {
    int len = strlen(password);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    for (int i = 0; i < len; i++) {
        result[i] = password[(i + key[i % keySize]) % len];
    }
    result[len] = '\0';
    return result;
}