#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int runeReserve(int* runes, int runesSize) {
    qsort(runes, runesSize, sizeof(int), compare);
    int count = 1;
    int current = 1;
    for (int i = 1; i < runesSize; i++) {
        if (runes[i] == runes[i - 1] + 1) {
            current++;
        } else {
            if (current > count) {
                count = current;
            }
            current = 1;
        }
    }
    if (current > count) {
        count = current;
    }
    return count;
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}