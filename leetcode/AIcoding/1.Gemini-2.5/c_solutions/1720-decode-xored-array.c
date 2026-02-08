#include <stdlib.h>

int* decode(int* encoded, int encodedSize, int first, int* returnSize) {
    int* arr = (int*)malloc((encodedSize + 1) * sizeof(int));
    arr[0] = first;
    *returnSize = encodedSize + 1;

    for (int i = 0; i < encodedSize; i++) {
        arr[i + 1] = arr[i] ^ encoded[i];
    }

    return arr;
}