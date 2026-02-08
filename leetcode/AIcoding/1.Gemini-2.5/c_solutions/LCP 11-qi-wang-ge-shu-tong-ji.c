#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int start;
    int end;
} Range;

int compareRanges(const void* a, const void* b) {
    const int* rangeA = *(const int**)a;
    const int* rangeB = *(const int**)b;
    if (rangeA[0] != rangeB[0]) {
        return rangeA[0] - rangeB[0];
    }
    return rangeA[1] - rangeB[1];
}

int compareInts(const void* a, const void* b) {
    return *(const int*)a - *(const int*)b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int countExpectedNumbers(int* nums, int numsSize, int** ranges, int rangesSize, int* rangesColSize) {
    if (numsSize == 0 || rangesSize == 0) {
        return 0;
    }

    qsort(ranges, rangesSize, sizeof(int*), compareRanges);

    Range* mergedRanges = (Range*)malloc(rangesSize * sizeof(Range));
    int mergedCount = 0;

    mergedRanges[mergedCount].start = ranges[0][0];
    mergedRanges[mergedCount].end = ranges[0][1];
    mergedCount++;

    for (int i = 1; i < rangesSize; i++) {
        if (ranges[i][0] <= mergedRanges[mergedCount - 1].end) {
            mergedRanges[mergedCount - 1].end = max(mergedRanges[mergedCount - 1].end, ranges[i][1]);
        } else {
            mergedRanges[mergedCount].start = ranges[i][0];
            mergedRanges[mergedCount].end = ranges[i][1];
            mergedCount++;
        }
    }

    qsort(nums, numsSize, sizeof(int), compareInts);

    int count = 0;
    int rangeIdx = 0;

    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];

        while (rangeIdx < mergedCount && mergedRanges[rangeIdx].end < num) {
            rangeIdx++;
        }

        if (rangeIdx < mergedCount && mergedRanges[rangeIdx].start <= num && mergedRanges[rangeIdx].end >= num) {
            count++;
        }
    }

    free(mergedRanges);

    return count;
}