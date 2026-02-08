#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestCommonPrefix(int* arr1, int size1, int* arr2, int size2) {
    int minSize = (size1 < size2) ? size1 : size2;
    int count = 0;

    for (int i = 0; i < minSize; i++) {
        if (arr1[i] == arr2[i]) {
            count++;
        } else {
            break;
        }
    }

    return count;
}