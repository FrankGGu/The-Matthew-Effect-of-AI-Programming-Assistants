#include <stdio.h>
#include <stdlib.h>

int hIndex(int* citations, int citationsSize) {
    int i, j;
    for (i = citationsSize; i > 0; i--) {
        int count = 0;
        for (j = 0; j < citationsSize; j++) {
            if (citations[j] >= i) {
                count++;
            }
        }
        if (count >= i) {
            return i;
        }
    }
    return 0;
}