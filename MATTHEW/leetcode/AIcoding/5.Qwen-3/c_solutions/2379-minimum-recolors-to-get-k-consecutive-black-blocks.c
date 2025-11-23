#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumRecolors(char* blocks, int k) {
    int n = strlen(blocks);
    int minRecolors = k;
    int count = 0;

    for (int i = 0; i < k; i++) {
        if (blocks[i] == 'B') {
            count++;
        }
    }

    minRecolors = k - count;

    for (int i = k; i < n; i++) {
        if (blocks[i - k] == 'B') {
            count--;
        }
        if (blocks[i] == 'B') {
            count++;
        }
        minRecolors = (k - count) < minRecolors ? (k - count) : minRecolors;
    }

    return minRecolors;
}