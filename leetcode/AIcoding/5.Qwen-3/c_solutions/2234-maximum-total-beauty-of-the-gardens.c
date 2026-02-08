#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int flower;
    int beauty;
} Flower;

int compare(const void *a, const void *b) {
    return ((Flower *)a)->flower - ((Flower *)b)->flower;
}

long long maxTotalBeauty(int** flowers, int flowersSize, int* flowersColSize, int newFlowers, int newPeople) {
    Flower *sorted = (Flower *)malloc(flowersSize * sizeof(Flower));
    for (int i = 0; i < flowersSize; i++) {
        sorted[i].flower = flowers[i][0];
        sorted[i].beauty = flowers[i][1];
    }
    qsort(sorted, flowersSize, sizeof(Flower), compare);

    int *prefix = (int *)malloc(flowersSize * sizeof(int));
    prefix[0] = sorted[0].beauty;
    for (int i = 1; i < flowersSize; i++) {
        prefix[i] = prefix[i - 1] + sorted[i].beauty;
    }

    int *counts = (int *)malloc(flowersSize * sizeof(int));
    int count = 0;
    for (int i = 0; i < flowersSize; i++) {
        if (i == 0 || sorted[i].flower != sorted[i - 1].flower) {
            counts[count++] = 1;
        } else {
            counts[count - 1]++;
        }
    }

    int *unique = (int *)malloc(count * sizeof(int));
    for (int i = 0; i < count; i++) {
        unique[i] = sorted[i].flower;
    }

    long long res = 0;
    int left = 0;
    int right = count - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        long long total = 0;
        for (int i = 0; i <= mid; i++) {
            total += (unique[i] - (i == 0 ? 0 : unique[i - 1])) * counts[i];
        }
        if (total <= newFlowers) {
            res = prefix[mid];
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    free(sorted);
    free(prefix);
    free(counts);
    free(unique);
    return res;
}