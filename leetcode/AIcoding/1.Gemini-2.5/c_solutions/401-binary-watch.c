#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int countSetBits(int n) {
    int count = 0;
    while (n > 0) {
        n &= (n - 1);
        count++;
    }
    return count;
}

char** readBinaryWatch(int num, int* returnSize) {
    char** result = (char**)malloc(sizeof(char*) * 720);
    *returnSize = 0;

    for (int h = 0; h < 12; h++) {
        for (int m = 0; m < 60; m++) {
            if (countSetBits(h) + countSetBits(m) == num) {
                char* time_str = (char*)malloc(sizeof(char) * 6);
                sprintf(time_str, "%d:%02d", h, m);
                result[*returnSize] = time_str;
                (*returnSize)++;
            }
        }
    }

    return result;
}