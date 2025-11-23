#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* nums;
    int size;
} FindSumPairs;

FindSumPairs* findSumPairsCreate(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    FindSumPairs* obj = (FindSumPairs*)malloc(sizeof(FindSumPairs));
    obj->nums = (int*)malloc(nums2Size * sizeof(int));
    for (int i = 0; i < nums2Size; i++) {
        obj->nums[i] = nums2[i];
    }
    obj->size = nums2Size;
    return obj;
}

void findSumPairsAdd(FindSumPairs* obj, int index, int val) {
    obj->nums[index] += val;
}

void findSumPairsDelete(FindSumPairs* obj) {
    free(obj->nums);
    free(obj);
}

int findSumPairsCount(FindSumPairs* obj, int target) {
    int count = 0;
    int* freq = (int*)calloc(10001, sizeof(int));
    for (int i = 0; i < obj->size; i++) {
        freq[obj->nums[i]]++;
    }
    for (int i = 0; i < obj->size; i++) {
        int complement = target - obj->nums[i];
        if (complement >= 0 && complement <= 10000) {
            count += freq[complement];
        }
    }
    free(freq);
    return count;
}