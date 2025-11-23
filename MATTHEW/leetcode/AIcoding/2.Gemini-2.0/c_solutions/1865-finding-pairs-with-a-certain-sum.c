#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* nums1;
    int nums1Size;
    int* nums2;
    int nums2Size;
    int* freq;
    int freqSize;
} FindSumPairs;

FindSumPairs* findSumPairsCreate(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    FindSumPairs* obj = (FindSumPairs*)malloc(sizeof(FindSumPairs));
    obj->nums1 = nums1;
    obj->nums1Size = nums1Size;
    obj->nums2 = nums2;
    obj->nums2Size = nums2Size;

    int maxVal = 0;
    for (int i = 0; i < nums2Size; i++) {
        if (nums2[i] > maxVal) {
            maxVal = nums2[i];
        }
    }

    obj->freqSize = maxVal + 1;
    obj->freq = (int*)calloc(obj->freqSize, sizeof(int));

    for (int i = 0; i < nums2Size; i++) {
        obj->freq[nums2[i]]++;
    }

    return obj;
}

void findSumPairsAdd(FindSumPairs* obj, int index, int val) {
    obj->freq[obj->nums2[index]]--;
    obj->nums2[index] += val;
    obj->freq[obj->nums2[index]]++;
}

int findSumPairsCount(FindSumPairs* obj, int tot) {
    int count = 0;
    for (int i = 0; i < obj->nums1Size; i++) {
        if (tot - obj->nums1[i] >= 0 && tot - obj->nums1[i] < obj->freqSize) {
            count += obj->freq[tot - obj->nums1[i]];
        }
    }
    return count;
}

void findSumPairsFree(FindSumPairs* obj) {
    free(obj->freq);
    free(obj);
}