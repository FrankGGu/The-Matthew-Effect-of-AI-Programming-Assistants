#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool* kidsWithCandies(int* candies, int candiesSize, int extraCandies, int* returnSize){
    int max = 0;
    for(int i = 0; i < candiesSize; i++){
        if(candies[i] > max){
            max = candies[i];
        }
    }

    bool* result = (bool*)malloc(candiesSize * sizeof(bool));
    *returnSize = candiesSize;

    for(int i = 0; i < candiesSize; i++){
        if(candies[i] + extraCandies >= max){
            result[i] = true;
        } else {
            result[i] = false;
        }
    }

    return result;
}