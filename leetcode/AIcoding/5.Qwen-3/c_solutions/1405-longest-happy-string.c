#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* longestHappyString(int a, int b, int c) {
    char* result = (char*)malloc(1000 * sizeof(char));
    int len = 0;
    int count[3] = {a, b, c};
    int last[2] = {-1, -1};

    while (len < 1000) {
        int max = -1, idx = -1;
        for (int i = 0; i < 3; i++) {
            if (i != last[0] && i != last[1] && count[i] > max) {
                max = count[i];
                idx = i;
            }
        }
        if (idx == -1) break;
        result[len++] = 'a' + idx;
        count[idx]--;
        last[1] = last[0];
        last[0] = idx;
    }
    result[len] = '\0';
    return result;
}