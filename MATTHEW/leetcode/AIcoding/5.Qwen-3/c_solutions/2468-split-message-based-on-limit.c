#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* splitMessage(int* message, int messageSize, int limit, int* returnSize) {
    int len = messageSize;
    int* result = (int*)malloc(sizeof(int) * len);
    int count = 0;

    for (int i = 0; i < len; i++) {
        int msgLen = 0;
        int idx = i;
        while (idx < len && msgLen + (int)(log10(idx + 1) + 1) + (int)(log10(i + 1) + 1) <= limit) {
            msgLen++;
            idx++;
        }
        if (msgLen > 0) {
            result[count++] = msgLen;
            i = idx - 1;
        } else {
            *returnSize = 0;
            free(result);
            return NULL;
        }
    }

    *returnSize = count;
    return result;
}