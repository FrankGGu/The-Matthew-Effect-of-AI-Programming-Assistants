#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int sum;
    int a;
    int b;
} Pair;

int compare(const void* a, const void* b) {
    return (*(Pair*)a).sum - (*(Pair*)b).sum;
}

int** kSmallestPairs(int* nums1, int nums1Size, int* nums2, int nums2Size, int k, int** returnColumnSizes) {
    int** result = (int**)malloc(sizeof(int*) * k);
    Pair* pairs = (Pair*)malloc(sizeof(Pair) * nums1Size * nums2Size);
    int count = 0;

    for (int i = 0; i < nums1Size; i++) {
        for (int j = 0; j < nums2Size; j++) {
            pairs[count].sum = nums1[i] + nums2[j];
            pairs[count].a = nums1[i];
            pairs[count].b = nums2[j];
            count++;
        }
    }

    qsort(pairs, count, sizeof(Pair), compare);

    *returnColumnSizes = (int*)malloc(sizeof(int) * k);
    for (int i = 0; i < k && i < count; i++) {
        result[i] = (int*)malloc(sizeof(int) * 2);
        result[i][0] = pairs[i].a;
        result[i][1] = pairs[i].b;
        (*returnColumnSizes)[i] = 2;
    }

    free(pairs);
    return result;
}