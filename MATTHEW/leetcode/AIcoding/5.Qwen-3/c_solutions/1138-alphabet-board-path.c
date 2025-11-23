#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* alphabetBoardPath(char* target, int* returnSize) {
    char* result = (char*)malloc(1000 * sizeof(char));
    int index = 0;
    int x = 0, y = 0;
    for (int i = 0; target[i]; i++) {
        char c = target[i];
        int tx = (c - 'a') / 5;
        int ty = (c - 'a') % 5;
        while (y > ty) { result[index++] = 'U'; y--; }
        while (x > tx) { result[index++] = 'L'; x--; }
        while (y < ty) { result[index++] = 'D'; y++; }
        while (x < tx) { result[index++] = 'R'; x++; }
        result[index++] = '!';
    }
    result[index] = '\0';
    *returnSize = index;
    return result;
}