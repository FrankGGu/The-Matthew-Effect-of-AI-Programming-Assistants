#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int value;
    int index;
} Pair;

int compare(const void *a, const void *b) {
    Pair *x = (Pair *)a;
    Pair *y = (Pair *)b;
    return y->value - x->value;
}

long long maxScore(int *nums1, int nums1Size, int *nums2, int nums2Size, int k) {
    int n = nums1Size;
    Pair *pairs = (Pair *)malloc(n * sizeof(Pair));
    for (int i = 0; i < n; i++) {
        pairs[i].value = nums1[i];
        pairs[i].index = i;
    }
    qsort(pairs, n, sizeof(Pair), compare);

    int *indices = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        indices[i] = pairs[i].index;
    }

    long long sum = 0;
    for (int i = 0; i < k; i++) {
        sum += nums1[indices[i]];
    }

    long long maxScore = sum * nums2[indices[0]];

    for (int i = k; i < n; i++) {
        sum -= nums1[indices[i - k]];
        sum += nums1[indices[i]];
        long long currentScore = sum * nums2[indices[i]];
        if (currentScore > maxScore) {
            maxScore = currentScore;
        }
    }

    free(pairs);
    free(indices);
    return maxScore;
}