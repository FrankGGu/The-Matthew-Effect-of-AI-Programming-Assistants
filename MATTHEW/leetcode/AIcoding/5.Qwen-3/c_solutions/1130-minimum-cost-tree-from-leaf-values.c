#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minCostTreeFromLeafValues(int* arr, int arrSize) {
    int* temp = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        temp[i] = arr[i];
    }

    int totalCost = 0;
    while (arrSize > 1) {
        int minIndex = 0;
        for (int i = 1; i < arrSize; i++) {
            if (temp[i] < temp[minIndex]) {
                minIndex = i;
            }
        }

        int left = minIndex == 0 ? 0 : minIndex - 1;
        int right = minIndex == arrSize - 1 ? arrSize - 1 : minIndex + 1;

        int minVal = temp[minIndex];
        int cost = 0;

        if (left >= 0) {
            cost += temp[left] * minVal;
        }
        if (right < arrSize) {
            cost += temp[right] * minVal;
        }

        totalCost += cost;

        int newLen = arrSize - 1;
        int* newTemp = (int*)malloc(newLen * sizeof(int));
        int k = 0;
        for (int i = 0; i < arrSize; i++) {
            if (i != minIndex) {
                newTemp[k++] = temp[i];
            }
        }
        newTemp[k++] = minVal;

        free(temp);
        temp = newTemp;
        arrSize = newLen;
    }

    free(temp);
    return totalCost;
}