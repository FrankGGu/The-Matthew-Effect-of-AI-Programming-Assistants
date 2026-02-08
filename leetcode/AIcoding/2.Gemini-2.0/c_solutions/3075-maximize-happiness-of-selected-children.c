#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumHappiness(int *happiness, int happinessSize, int k) {
    qsort(happiness, happinessSize, sizeof(int), (int (*)(const void *, const void *))compare);
    int sum = 0;
    for (int i = happinessSize - 1; i >= happinessSize - k; i--) {
        sum += happiness[i];
    }
    return sum;
}

int compare(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}