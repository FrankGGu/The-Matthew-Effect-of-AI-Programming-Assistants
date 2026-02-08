#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minRecolors(char * blocks, int k){
    int n = strlen(blocks);
    int white_count = 0;
    for (int i = 0; i < k; i++) {
        if (blocks[i] == 'W') {
            white_count++;
        }
    }
    int min_recolors = white_count;
    for (int i = k; i < n; i++) {
        if (blocks[i] == 'W') {
            white_count++;
        }
        if (blocks[i - k] == 'W') {
            white_count--;
        }
        min_recolors = (white_count < min_recolors) ? white_count : min_recolors;
    }
    return min_recolors;
}