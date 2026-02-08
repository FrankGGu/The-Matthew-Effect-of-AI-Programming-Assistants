#include <string.h>
#include <stdlib.h>

struct Codec {
};

void codec_init(struct Codec* obj) {
}

char* encode(struct Codec* obj, char** strs, int strsSize) {
    int total_length = 0;
    for (int i = 0; i < strsSize; i++) {
        total_length += strlen(strs[i]) + 1; // +1 for the delimiter
    }
    char* encoded = (char*)malloc(total_length * sizeof(char));
    int index = 0;
    for (int i = 0; i < strsSize; i++) {
        index += sprintf(encoded + index, "%s%c", strs[i], '\0');
    }
    return encoded;
}

char** decode(struct Codec* obj, char* s, int* returnSize) {
    char** decoded = (char**)malloc(1000 * sizeof(char*));
    *returnSize = 0;
    char* token = s;
    while (*token) {
        decoded[*returnSize] = token;
        (*returnSize)++;
        token += strlen(token) + 1;
    }
    return decoded;
}

void codec_free(struct Codec* obj) {
    free(obj);
}