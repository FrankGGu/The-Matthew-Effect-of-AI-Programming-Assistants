#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* executeInstructions(int n, int* position, int positionSize, char* s, int* returnSize) {
    int len = strlen(s);
    int* result = (int*)malloc(sizeof(int) * len);
    *returnSize = len;

    for (int i = 0; i < len; i++) {
        int x = position[0];
        int y = position[1];
        int count = 0;
        for (int j = i; j < len; j++) {
            if (s[j] == 'R') {
                y++;
            } else if (s[j] == 'L') {
                y--;
            } else if (s[j] == 'U') {
                x--;
            } else {
                x++;
            }

            if (x < 0 || x >= n || y < 0 || y >= n) {
                break;
            }
            count++;
        }
        result[i] = count;
    }

    return result;
}