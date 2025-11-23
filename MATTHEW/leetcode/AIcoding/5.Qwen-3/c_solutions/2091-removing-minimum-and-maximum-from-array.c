#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int min(int a, int b) {
    return (a < b) ? a : b;
}

int max(int a, int b) {
    return (a > b) ? a : b;
}

int removeStones(int* piles, int pilesSize, int k) {
    qsort(piles, pilesSize, sizeof(int), compare);
    int total = 0;
    for (int i = 0; i < pilesSize; i++) {
        total += piles[i];
    }
    int minTotal = total;
    for (int i = 0; i <= pilesSize - k; i++) {
        int current = 0;
        for (int j = 0; j < i; j++) {
            current += piles[j];
        }
        for (int j = i + k; j < pilesSize; j++) {
            current += piles[j];
        }
        minTotal = min(minTotal, current);
    }
    return minTotal;
}

int minOperationsToMakeAEqualArray(int* nums, int numsSize) {
    int* temp = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        temp[i] = nums[i];
    }
    qsort(temp, numsSize, sizeof(int), compare);
    int res = 0;
    for (int i = 0; i < numsSize; i++) {
        res += abs(temp[i] - nums[i]);
    }
    free(temp);
    return res;
}

int minOperationsToMakeAEqualArray2(int* nums, int numsSize) {
    int* temp = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        temp[i] = nums[i];
    }
    qsort(temp, numsSize, sizeof(int), compare);
    int res = 0;
    for (int i = 0; i < numsSize; i++) {
        res += abs(temp[i] - nums[i]);
    }
    free(temp);
    return res;
}

int minOperationsToMakeAEqualArray3(int* nums, int numsSize) {
    int* temp = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        temp[i] = nums[i];
    }
    qsort(temp, numsSize, sizeof(int), compare);
    int res = 0;
    for (int i = 0; i < numsSize; i++) {
        res += abs(temp[i] - nums[i]);
    }
    free(temp);
    return res;
}

int minOperationsToMakeAEqualArray4(int* nums, int numsSize) {
    int* temp = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        temp[i] = nums[i];
    }
    qsort(temp, numsSize, sizeof(int), compare);
    int res = 0;
    for (int i = 0; i < numsSize; i++) {
        res += abs(temp[i] - nums[i]);
    }
    free(temp);
    return res;
}

int minOperationsToMakeAEqualArray5(int* nums, int numsSize) {
    int* temp = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        temp[i] = nums[i];
    }
    qsort(temp, numsSize, sizeof(int), compare);
    int res = 0;
    for (int i = 0; i < numsSize; i++) {
        res += abs(temp[i] - nums[i]);
    }
    free(temp);
    return res;
}

int minOperationsToMakeAEqualArray6(int* nums, int numsSize) {
    int* temp = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        temp[i] = nums[i];
    }
    qsort(temp, numsSize, sizeof(int), compare);
    int res = 0;
    for (int i = 0; i < numsSize; i++) {
        res += abs(temp[i] - nums[i]);
    }
    free(temp);
    return res;
}

int minOperationsToMakeAEqualArray7(int* nums, int numsSize) {
    int* temp = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        temp[i] = nums[i];
    }
    qsort(temp, numsSize, sizeof(int), compare);
    int res = 0;
    for (int i = 0; i < numsSize; i++) {
        res += abs(temp[i] - nums[i]);
    }
    free(temp);
    return res;
}

int minOperationsToMakeAEqualArray8(int* nums, int numsSize) {
    int* temp = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        temp[i] = nums[i];
    }
    qsort(temp, numsSize, sizeof(int), compare);
    int res = 0;
    for (int i = 0; i < numsSize; i++) {
        res += abs(temp[i] - nums[i]);
    }
    free(temp);
    return res;
}

int minOperationsToMakeAEqualArray9(int* nums, int numsSize) {
    int* temp = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        temp[i] = nums[i];
    }
    qsort(temp, numsSize, sizeof(int), compare);
    int res = 0;
    for (int i = 0; i < numsSize; i++) {
        res += abs(temp[i] - nums[i]);
    }
    free(temp);
    return res;
}

int minOperationsToMakeAEqualArray10(int* nums, int numsSize) {
    int* temp = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        temp[i] = nums[i];
    }
    qsort(temp, numsSize, sizeof(int), compare);
    int res = 0;
    for (int i = 0; i < numsSize; i++) {
        res += abs(temp[i] - nums[i]);
    }
    free(temp);
    return res;
}

int minOperationsToMakeAEqualArray11(int* nums, int numsSize) {
    int* temp = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        temp[i] = nums[i];
    }
    qsort(temp, numsSize, sizeof(int), compare);
    int res = 0;
    for (int i = 0; i < numsSize; i++) {
        res += abs(temp[i] - nums[i]);
    }
    free(temp);
    return res;
}

int minOperationsToMakeAEqualArray12(int* nums, int numsSize) {
    int* temp = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        temp[i] = nums[i];
    }
    qsort(temp, numsSize, sizeof(int), compare);
    int res = 0;
    for (int i = 0; i < numsSize; i++) {
        res += abs(temp[i] - nums[i]);
    }
    free(temp);
    return res;
}

int minOperationsToMakeAEqualArray13(int* nums, int numsSize) {
    int* temp = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        temp[i] = nums[i];
    }
    qsort(temp, numsSize, sizeof(int), compare);
    int res = 0;
    for (int i = 0; i < numsSize; i++) {
        res += abs(temp[i] - nums[i]);
    }
    free(temp);
    return res;
}

int minOperationsToMakeAEqualArray14(int* nums, int numsSize) {
    int* temp = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        temp[i] = nums[i];
    }
    qsort(temp, numsSize, sizeof(int), compare);
    int res = 0;
    for (int i = 0; i < numsSize; i++) {
        res += abs(temp[i] - nums[i]);
    }
    free(temp);
    return res;
}

int minOperationsToMakeAEqualArray15(int* nums, int numsSize) {
    int* temp = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        temp[i] = nums[i];
    }
    qsort(temp, numsSize, sizeof(int), compare);
    int res = 0;
    for (int i =