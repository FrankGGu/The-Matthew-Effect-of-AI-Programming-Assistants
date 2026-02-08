#include <stdlib.h>
#include <string.h>

int compareInts(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int compareCuboidsPointers(const void *a, const void *b) {
    int *cuboid1 = *(int **)a; // Dereference void* to get int* (the cuboid array)
    int *cuboid2 = *(int **)b; // Dereference void* to get int* (the cuboid array)

    // Sort by largest dimension (cuboid[2]) in descending order
    if (cuboid1[2] != cuboid2[2]) {
        return cuboid2[2] - cuboid1[2];
    }
    // Then by middle dimension (cuboid[1]) in descending order
    if (cuboid1[1] != cuboid2[1]) {
        return cuboid2[1] - cuboid1[1];
    }
    // Then by smallest dimension (cuboid[0]) in descending order
    return cuboid2[0] - cuboid1[0];
}

int max(int a, int b) {
    return a > b ? a : b;
}

int maxHeight(int** cuboids, int cuboidsSize, int* cuboidsColSize) {
    if (cuboidsSize == 0) {
        return 0;
    }

    // Step 1: For each cuboid, sort its dimensions in non-decreasing order.
    // This ensures that for any cuboid, its dimensions are [l, w, h] where l <= w <= h.
    for (int i = 0; i < cuboidsSize; i++) {
        qsort(cuboids[i], 3, sizeof(int), compareInts);
    }

    // Step 2: Sort all cuboids based on their dimensions.
    // Sorting in descending order of (h, w, l) ensures that when we iterate through
    // the cuboids for DP, any cuboid `j` that appears before `i` in the sorted list
    // is "larger" or equal in terms of dimensions, making it a potential base for `i`.
    qsort(cuboids, cuboidsSize, sizeof(int*), compareCuboidsPointers);

    // Step 3: Dynamic Programming
    // dp[i] stores the maximum height achievable with cuboid[i] being the top-most cuboid
    // in a valid stack.
    int* dp = (int*)malloc(cuboidsSize * sizeof(int));
    int overallMaxHeight = 0;

    for (int i = 0; i < cuboidsSize; i++) {
        // Initialize dp[i] with the height of the cuboid itself (a stack of one cuboid)
        dp[i] = cuboids[i][2];

        // Iterate through previous cuboids to find a suitable base
        for (int j = 0; j < i; j++) {
            // Check if cuboid[i] can be placed on top of cuboid[j].
            // This condition is met if all dimensions of cuboid[i] are less than or
            // equal to the corresponding dimensions of cuboid[j].
            if (cuboids[i][0] <= cuboids[j][0] &&
                cuboids[i][1] <= cuboids[j][1] &&
                cuboids[i][2] <= cuboids[j][2]) {
                // If it can be placed, update dp[i] with the maximum height
                // achieved by stacking cuboid[i] on top of the stack ending at cuboid[j].
                dp[i] = max(dp[i], dp[j] + cuboids[i][2]);
            }
        }
        // Update the overall maximum height found so far
        overallMaxHeight = max(overallMaxHeight, dp[i]);
    }

    free(dp); // Free dynamically allocated memory
    return overallMaxHeight;
}