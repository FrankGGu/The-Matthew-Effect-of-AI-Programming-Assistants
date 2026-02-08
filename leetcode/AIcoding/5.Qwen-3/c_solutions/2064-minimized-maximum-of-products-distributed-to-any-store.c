#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minimizeStore(int* quantities, int quantitiesSize, int n) {
    qsort(quantities, quantitiesSize, sizeof(int), compare);

    int left = 1;
    int right = quantities[quantitiesSize - 1];
    int answer = right;

    while (left <= right) {
        int mid = (left + right) / 2;
        int count = 0;

        for (int i = 0; i < quantitiesSize; i++) {
            count += (quantities[i] + mid - 1) / mid;
        }

        if (count <= n) {
            answer = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return answer;
}