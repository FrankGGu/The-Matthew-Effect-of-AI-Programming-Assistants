#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int leastBricks(int** wall, int wallSize, int* wallColSize){
    int width = 0;
    for(int i = 0; i < wallColSize[0]; i++){
        width += wall[0][i];
    }

    int* count = (int*)calloc(width, sizeof(int));
    if(count == NULL) return -1;

    for(int i = 0; i < wallSize; i++){
        int sum = 0;
        for(int j = 0; j < wallColSize[i] - 1; j++){
            sum += wall[i][j];
            count[sum]++;
        }
    }

    int maxCount = 0;
    for(int i = 1; i < width; i++){
        if(count[i] > maxCount){
            maxCount = count[i];
        }
    }

    free(count);
    return wallSize - maxCount;
}