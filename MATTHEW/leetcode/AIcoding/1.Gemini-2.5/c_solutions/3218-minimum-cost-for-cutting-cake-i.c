#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int minimumCost(int* horizontalCut, int horizontalCutSize, int* verticalCut, int verticalCutSize) {
    // Sort both arrays in descending order
    qsort(horizontalCut, horizontalCutSize, sizeof(int), compare);
    qsort(verticalCut, verticalCutSize, sizeof(int), compare);

    long long totalCost = 0;
    int horizontalPieces = 1; // Initially 1 piece horizontally
    int verticalPieces = 1;   // Initially 1 piece vertically

    int i = 0; // Pointer for horizontalCut
    int j = 0; // Pointer for verticalCut

    // Merge-like process to pick the largest available cut
    while (i < horizontalCutSize || j < verticalCutSize) {
        if (i < horizontalCutSize && (j == verticalCutSize || horizontalCut[i] >= verticalCut[j])) {
            // Take the current largest horizontal cut
            totalCost += (long long)horizontalCut[i] * verticalPieces;
            horizontalPieces++;
            i++;
        } else if (j < verticalCutSize) {
            // Take the current largest vertical cut
            totalCost += (long long)verticalCut[j] * horizontalPieces;
            verticalPieces++;
            j++;
        }
    }

    return (int)totalCost;
}