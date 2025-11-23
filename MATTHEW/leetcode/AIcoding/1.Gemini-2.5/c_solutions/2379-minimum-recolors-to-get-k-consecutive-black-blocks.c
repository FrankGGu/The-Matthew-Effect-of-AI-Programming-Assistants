#include <string.h>

int minimumRecolors(char * blocks, int k){
    int n = strlen(blocks);
    int min_recolors = k; 
    int current_recolors = 0;

    for (int i = 0; i < k; i++) {
        if (blocks[i] == 'W') {
            current_recolors++;
        }
    }
    min_recolors = current_recolors;

    for (int i = 1; i <= n - k; i++) {
        if (blocks[i - 1] == 'W') {
            current_recolors--;
        }
        if (blocks[i + k - 1] == 'W') {
            current_recolors++;
        }
        if (current_recolors < min_recolors) {
            min_recolors = current_recolors;
        }
    }

    return min_recolors;
}