#include <stdio.h>
#include <stdlib.h>

int* getRotatedArray(int* nums, int numsSize);
int maxScoreSides(int* nums, int numsSize);
int* createScoreArray(int* nums, int numsSize);
int* getRotationScores(int* nums, int numsSize);
int* smallestRotationHighestScore(int* nums, int numsSize);

int* getRotatedArray(int* nums, int numsSize) {
    int* rotated = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        rotated[i] = nums[(i + 1) % numsSize];
    }
    return rotated;
}

int maxScoreSides(int* nums, int numsSize) {
    int* score = (int*)calloc(numsSize, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsSize; j++) {
            if (nums[j] < nums[i]) {
                score[i]++;
            }
        }
    }
    int max = 0;
    for (int i = 0; i < numsSize; i++) {
        if (score[i] > max) {
            max = score[i];
        }
    }
    free(score);
    return max;
}

int* createScoreArray(int* nums, int numsSize) {
    int* score = (int*)calloc(numsSize, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < numsSize; j++) {
            if (nums[j] < nums[i]) {
                score[i]++;
            }
        }
    }
    return score;
}

int* getRotationScores(int* nums, int numsSize) {
    int* scores = (int*)calloc(numsSize, sizeof(int));
    for (int k = 0; k < numsSize; k++) {
        int* rotated = getRotatedArray(nums, numsSize);
        int* score = createScoreArray(rotated, numsSize);
        int total = 0;
        for (int i = 0; i < numsSize; i++) {
            total += score[i];
        }
        scores[k] = total;
        free(rotated);
        free(score);
    }
    return scores;
}

int* smallestRotationHighestScore(int* nums, int numsSize) {
    int* scores = getRotationScores(nums, numsSize);
    int maxScore = 0;
    for (int i = 0; i < numsSize; i++) {
        if (scores[i] > maxScore) {
            maxScore = scores[i];
        }
    }
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (scores[i] == maxScore) {
            count++;
        }
    }
    int* result = (int*)malloc(count * sizeof(int));
    int idx = 0;
    for (int i = 0; i < numsSize; i++) {
        if (scores[i] == maxScore) {
            result[idx++] = i;
        }
    }
    free(scores);
    return result;
}