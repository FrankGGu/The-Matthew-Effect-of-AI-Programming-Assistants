#include <stdio.h>
#include <stdlib.h>

int* diStringMatch(char* s, int sSize) {
    int* result = (int*)malloc(sSize * sizeof(int));
    int left = 0;
    int right = sSize;
    for (int i = 0; i < sSize; i++) {
        if (s[i] == 'I') {
            result[i] = left++;
        } else {
            result[i] = right--;
        }
    }
    result[sSize] = left;
    return result;
}