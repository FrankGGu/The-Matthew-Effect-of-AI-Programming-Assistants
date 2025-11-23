#include <stdio.h>
#include <stdlib.h>

int* decode(int* encoded, int encodedSize, int first, int* returnSize) {
    int* result = (int*)malloc((encodedSize + 1) * sizeof(int));
    result[0] = first;
    for (int i = 0; i < encodedSize; i++) {
        result[i + 1] = result[i] ^ encoded[i];
    }
    *returnSize = encodedSize + 1;
    return result;
}