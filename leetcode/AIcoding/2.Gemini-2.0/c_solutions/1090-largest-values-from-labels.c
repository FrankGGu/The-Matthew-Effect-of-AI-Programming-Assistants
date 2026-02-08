#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)b) - (*(int*)a);
}

int largestValsFromLabels(int* values, int valuesSize, int* labels, int labelsSize, int numWanted, int useLimit) {
    int* sortedIndices = (int*)malloc(valuesSize * sizeof(int));
    for (int i = 0; i < valuesSize; i++) {
        sortedIndices[i] = i;
    }

    qsort(sortedIndices, valuesSize, sizeof(int), compare);

    int sum = 0;
    int count = 0;
    int* labelCounts = (int*)calloc(50001, sizeof(int)); 

    for (int i = 0; i < valuesSize && count < numWanted; i++) {
        int index = sortedIndices[i];
        int label = labels[index];

        if (labelCounts[label] < useLimit) {
            sum += values[index];
            labelCounts[label]++;
            count++;
        }
    }

    free(sortedIndices);
    free(labelCounts);

    return sum;
}