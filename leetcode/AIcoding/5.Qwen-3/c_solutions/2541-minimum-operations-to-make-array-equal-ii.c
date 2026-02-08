#include <stdio.h>
#include <stdlib.h>

long long int compare(const void *a, const void *b) {
    return (*(long long int*)a - *(long long int*)b);
}

long long int minOperations(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    long long int* diff = (long long int*)malloc((nums1Size + nums2Size) * sizeof(long long int));
    int index = 0;

    for (int i = 0; i < nums1Size; i++) {
        diff[index++] = nums1[i];
    }

    for (int i = 0; i < nums2Size; i++) {
        diff[index++] = -nums2[i];
    }

    qsort(diff, index, sizeof(long long int), compare);

    long long int operations = 0;
    long long int current = 0;

    for (int i = 0; i < index; i++) {
        current += diff[i];
        if (current > 0) {
            operations++;
            current = 0;
        }
    }

    free(diff);
    return operations;
}