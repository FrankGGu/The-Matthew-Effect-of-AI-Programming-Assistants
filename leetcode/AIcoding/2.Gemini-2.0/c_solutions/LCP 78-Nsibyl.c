#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int min(int a, int b) {
    return (a < b) ? a : b;
}

int leastBricks(int** wall, int wallSize, int* wallColSize){
    int max_overlap = 0;
    int hash_map[10001] = {0}; 

    for (int i = 0; i < wallSize; i++) {
        int sum = 0;
        for (int j = 0; j < wallColSize[i] - 1; j++) {
            sum += wall[i][j];
            hash_map[sum]++;
            max_overlap = max(max_overlap, hash_map[sum]);
        }
    }

    return wallSize - max_overlap;
}