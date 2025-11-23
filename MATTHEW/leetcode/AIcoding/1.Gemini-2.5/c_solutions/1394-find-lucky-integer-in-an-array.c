#include <stdlib.h> // Not strictly needed for this solution, but good practice for C files

int findLucky(int* arr, int arrSize) {
    int counts[501] = {0}; // Constraints: 1 <= arr[i] <= 500

    for (int i = 0; i < arrSize; i++) {
        counts[arr[i]]++;
    }

    int maxLucky = -1;
    for (int i = 500; i >= 1; i--) { // Iterate downwards to easily find the largest
        if (counts[i] == i) {
            maxLucky = i;
            break; // Found the largest lucky integer, no need to check smaller ones
        }
    }

    return maxLucky;
}