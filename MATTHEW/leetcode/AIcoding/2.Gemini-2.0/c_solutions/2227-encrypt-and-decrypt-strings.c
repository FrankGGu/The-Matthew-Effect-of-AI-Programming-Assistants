#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char keys[26];
    char values[26];
    int count;
} Encrypter;

Encrypter* encrypterCreate(char* keys, char* values, int keysSize) {
    Encrypter* obj = (Encrypter*)malloc(sizeof(Encrypter));
    obj->count = keysSize;
    memcpy(obj->keys, keys, keysSize * sizeof(char));
    memcpy(obj->values, values, keysSize * sizeof(char));
    return obj;
}

char* encrypterEncrypt(Encrypter* obj, char* word1) {
    int len = strlen(word1);
    char* result = (char*)malloc(len * 2 + 1);
    int index = 0;
    for (int i = 0; i < len; i++) {
        int found = 0;
        for (int j = 0; j < obj->count; j++) {
            if (word1[i] == obj->keys[j]) {
                result[index++] = obj->values[j * 2];
                result[index++] = obj->values[j * 2 + 1];
                found = 1;
                break;
            }
        }
        if (!found) {
            free(result);
            return "";
        }
    }
    result[index] = '\0';
    return result;
}

int encrypterDecrypt(Encrypter* obj, char* word2) {
    int len = strlen(word2);
    if (len % 2 != 0) {
        return 0;
    }
    int count = 0;

    int* dp = (int*)malloc((len / 2 + 1) * sizeof(int));
    dp[0] = 1;

    for (int i = 1; i <= len / 2; i++) {
        dp[i] = 0;
        for (int j = 0; j < obj->count; j++) {
            if (word2[(i - 1) * 2] == obj->values[j * 2] && word2[(i - 1) * 2 + 1] == obj->values[j * 2 + 1]) {
                dp[i] += dp[i - 1];
            }
        }
    }

    count = dp[len / 2];
    free(dp);
    return count;
}

void encrypterFree(Encrypter* obj) {
    free(obj);
}