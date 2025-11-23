#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* maxScoreIndices(int* nums, int numsSize, int* returnSize){
    int ones = 0;
    for(int i = 0; i < numsSize; i++){
        if(nums[i] == 1){
            ones++;
        }
    }

    int max_score = ones;
    int score = ones;
    for(int i = 0; i < numsSize; i++){
        if(nums[i] == 0){
            score++;
        } else {
            score--;
        }
        if(score > max_score){
            max_score = score;
        }
    }

    int count = 0;
    for(int i = 0; i < numsSize; i++){
        score = ones;
        for(int j = 0; j < i; j++){
            if(nums[j] == 0){
                score++;
            } else {
                score--;
            }
        }
        for(int j = i; j < numsSize; j++){
            if(nums[j] == 1){
                score--;
            }
        }
        if(i == 0 && score == max_score){
            count++;
        }
        if(score == max_score){
            count++;
        }
    }
    if(ones == max_score){
        count++;
    }

    int* result = (int*)malloc(sizeof(int) * count);
    *returnSize = 0;
    int current_score;
    if(ones == max_score){
        result[(*returnSize)++] = 0;
    }
    for(int i = 0; i < numsSize; i++){
        current_score = ones;
        for(int j = 0; j < i; j++){
            if(nums[j] == 0){
                current_score++;
            } else {
                current_score--;
            }
        }
        for(int j = i; j < numsSize; j++){
            if(nums[j] == 1){
                current_score--;
            }
        }

        if(current_score == max_score){
            result[(*returnSize)++] = i;
        }
    }

    return result;
}