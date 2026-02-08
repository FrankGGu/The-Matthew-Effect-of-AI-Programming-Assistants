#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** findOcurrences(char* content, char* key, int* returnSize) {
    int len = strlen(content);
    int keyLen = strlen(key);
    if (keyLen == 0 || len < keyLen) {
        *returnSize = 0;
        return NULL;
    }

    char** result = (char**)malloc(sizeof(char*));
    int count = 0;
    int i = 0;

    while (i <= len - keyLen) {
        int j;
        for (j = 0; j < keyLen; j++) {
            if (content[i + j] != key[j]) break;
        }
        if (j == keyLen) {
            int nextPos = i + keyLen;
            if (nextPos < len) {
                int start = nextPos;
                while (nextPos < len && content[nextPos] != ' ') nextPos++;
                int wordLen = nextPos - start;
                char* word = (char*)malloc(wordLen + 1);
                strncpy(word, content + start, wordLen);
                word[wordLen] = '\0';
                result = (char**)realloc(result, (count + 1) * sizeof(char*));
                result[count++] = word;
            }
        }
        i++;
    }

    *returnSize = count;
    return result;
}