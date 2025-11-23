#include <stdlib.h> // For qsort

int compareDescending(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

long long minimumCost(int m, int n, int* horizontalCut, int horizontalCutSize, int* verticalCut, int verticalCutSize) {
    // Sort horizontalCut and verticalCut arrays in descending order
    qsort(horizontalCut, horizontalCutSize, sizeof(int), compareDescending);
    qsort(verticalCut, verticalCutSize, sizeof(int), compareDescending);

    long long totalCost = 0;
    long long horizontalPieces = 1; // Number of cake pieces currently in horizontal dimension
    long long verticalPieces = 1;   // Number of cake pieces currently in vertical dimension

    int h_ptr = 0; // Pointer for horizontalCut array
    int v_ptr = 0; // Pointer for verticalCut array

    // Greedily pick the most expensive cut available (either horizontal or vertical)
    // The most expensive cuts should be made first because they will be multiplied
    // by the smallest number of existing pieces.
    while (h_ptr < horizontalCutSize && v_ptr < verticalCutSize) {
        if (horizontalCut[h_ptr] >= verticalCut[v_ptr]) {
            // Make the horizontal cut with cost horizontalCut[h_ptr]
            // This cut will pass through all existing 'verticalPieces' segments
            totalCost += (long long)horizontalCut[h_ptr] * verticalPieces;
            horizontalPieces++; // Increment the number of horizontal pieces
            h_ptr++;            // Move to the next horizontal cut
        } else {
            // Make the vertical cut with cost verticalCut[v_ptr]
            // This cut will pass through all existing 'horizontalPieces' segments
            totalCost += (long long)verticalCut[v_ptr] * horizontalPieces;
            verticalPieces++;   // Increment the number of vertical pieces
            v_ptr++;            // Move to the next vertical cut
        }
    }

    // Add remaining horizontal cuts (if any)
    while (h_ptr < horizontalCutSize) {
        totalCost += (long long)horizontalCut[h_ptr] * verticalPieces;
        horizontalPieces++; // Not strictly necessary for calculation but conceptually correct
        h_ptr++;
    }

    // Add remaining vertical cuts (if any)
    while (v_ptr < verticalCutSize) {
        totalCost += (long long)verticalCut[v_ptr] * horizontalPieces;
        verticalPieces++; // Not strictly necessary for calculation but conceptually correct
        v_ptr++;
    }

    return totalCost;
}