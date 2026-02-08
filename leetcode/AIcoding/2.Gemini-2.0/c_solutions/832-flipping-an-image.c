#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** flipAndInvertImage(int** image, int imageSize, int* imageColSize, int* returnSize, int** returnColumnSizes){
    *returnSize = imageSize;
    *returnColumnSizes = (int*)malloc(sizeof(int) * imageSize);
    for(int i = 0; i < imageSize; i++){
        (*returnColumnSizes)[i] = imageColSize[i];
    }

    int** result = (int**)malloc(sizeof(int*) * imageSize);
    for(int i = 0; i < imageSize; i++){
        result[i] = (int*)malloc(sizeof(int) * imageColSize[i]);
        int left = 0;
        int right = imageColSize[i] - 1;
        while(left <= right){
            if(left == right){
                result[i][left] = 1 - image[i][left];
            } else {
                int temp = 1 - image[i][left];
                result[i][left] = 1 - image[i][right];
                result[i][right] = temp;
            }
            left++;
            right--;
        }
    }

    return result;
}