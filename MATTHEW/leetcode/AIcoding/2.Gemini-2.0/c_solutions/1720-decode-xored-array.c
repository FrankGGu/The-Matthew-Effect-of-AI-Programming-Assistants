#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* decode(int* encoded, int encodedSize, int first, int* returnSize){
    int* decoded = (int*)malloc((encodedSize + 1) * sizeof(int));
    decoded[0] = first;
    for (int i = 0; i < encodedSize; i++) {
        decoded[i + 1] = decoded[i] ^ encoded[i];
    }
    *returnSize = encodedSize + 1;
    return decoded;
}