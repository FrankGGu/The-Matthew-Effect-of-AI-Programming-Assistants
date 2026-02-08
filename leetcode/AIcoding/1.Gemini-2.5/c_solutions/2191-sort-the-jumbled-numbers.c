#include <stdlib.h> // For malloc, qsort, free

long long calculateJumbledValue(int num, int* mapping) {
    if (num == 0) {
        return mapping[0];
    }

    long long jumbled = 0;
    long long place = 1;

    // Process digits from right to left
    while (num > 0) {
        int digit = num % 10;
        jumbled += (long long)mapping[digit] * place;
        place *= 10;
        num /= 10;
    }
    return jumbled;
}

typedef struct {
    int original_index;   // To maintain stability (original relative order) for equal jumbled values
    int original_value;
    long long jumbled_value; // Stores the calculated jumbled value (can be large)
} NumberInfo;

int compareNumberInfo(const void *a, const void *b) {
    NumberInfo *infoA = (NumberInfo *)a;
    NumberInfo *infoB = (NumberInfo *)b;

    // Primary sort key: jumbled_value
    if (infoA->jumbled_value < infoB->jumbled_value) {
        return -1;
    } else if (infoA->jumbled_value > infoB->jumbled_value) {
        return 1;
    }
    // Secondary sort key (for stability): original_index if jumbled_values are equal
    return infoA->original_index - infoB->original_index;
}

int* sortJumbled(int* mapping, int mappingSize, int* nums, int numsSize, int* returnSize) {
    // Allocate memory for an array of NumberInfo structs
    NumberInfo* infos = (NumberInfo*)malloc(numsSize * sizeof(NumberInfo));
    if (infos == NULL) {
        *returnSize = 0;
        return NULL; // Handle memory allocation failure
    }

    // Populate the NumberInfo array
    for (int i = 0; i < numsSize; i++) {
        infos[i].original_index = i;
        infos[i].original_value = nums[i];
        infos[i].jumbled_value = calculateJumbledValue(nums[i], mapping);
    }

    // Sort the NumberInfo array using qsort and the custom comparison function
    qsort(infos, numsSize, sizeof(NumberInfo), compareNumberInfo);

    // Allocate memory for the result array
    int* result = (int*)malloc(numsSize * sizeof(int));
    if (result == NULL) {
        free(infos); // Free previously allocated memory
        *returnSize = 0;
        return NULL; // Handle memory allocation failure
    }

    // Populate the result array with the original values from the sorted NumberInfo structs
    for (int i = 0; i < numsSize; i++) {
        result[i] = infos[i].original_value;
    }

    // Free the temporary NumberInfo array
    free(infos);

    // Set the return size
    *returnSize = numsSize;
    return result;
}