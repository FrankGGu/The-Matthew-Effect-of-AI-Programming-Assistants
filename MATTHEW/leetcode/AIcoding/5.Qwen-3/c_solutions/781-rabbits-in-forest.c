#include <stdio.h>
#include <stdlib.h>

int numRabbits(int* answers, int answersSize) {
    int* count = (int*)calloc(1000, sizeof(int));
    int result = 0;
    for (int i = 0; i < answersSize; i++) {
        int x = answers[i];
        if (count[x] == 0) {
            result += x + 1;
            count[x] = x;
        } else {
            count[x]--;
        }
    }
    free(count);
    return result;
}