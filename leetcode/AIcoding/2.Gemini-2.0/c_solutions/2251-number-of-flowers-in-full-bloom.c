#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* fullBloomFlowers(int** flowers, int flowersSize, int* flowersColSize, int* people, int peopleSize, int* returnSize) {
    int* bloom = (int*)malloc(sizeof(int) * flowersSize);
    int* die = (int*)malloc(sizeof(int) * flowersSize);
    int* ans = (int*)malloc(sizeof(int) * peopleSize);
    *returnSize = peopleSize;

    for (int i = 0; i < flowersSize; i++) {
        bloom[i] = flowers[i][0];
        die[i] = flowers[i][1];
    }

    qsort(bloom, flowersSize, sizeof(int), (int (*)(const void *, const void *))cmpfunc);
    qsort(die, flowersSize, sizeof(int), (int (*)(const void *, const void *))cmpfunc);

    for (int i = 0; i < peopleSize; i++) {
        int person = people[i];
        int bloomIndex = upper_bound(bloom, flowersSize, person);
        int dieIndex = lower_bound(die, flowersSize, person);
        ans[i] = bloomIndex - dieIndex;
    }

    free(bloom);
    free(die);

    return ans;
}

int cmpfunc(const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}

int upper_bound(int *arr, int n, int target) {
    int low = 0, high = n;
    while (low < high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] <= target) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }
    return low;
}

int lower_bound(int *arr, int n, int target) {
    int low = 0, high = n;
    while (low < high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] < target) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }
    return low;
}