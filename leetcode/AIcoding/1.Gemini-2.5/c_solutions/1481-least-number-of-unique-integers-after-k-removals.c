#include <stdlib.h> // Required for qsort and malloc

int compareInt(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findLeastNumOfUniqueInts(int* arr, int arrSize, int k) {
    if (arrSize == 0) {
        return 0;
    }

    // 1. Sort the input array to group identical elements together
    qsort(arr, arrSize, sizeof(int), compareInt);

    // 2. Count frequencies of each unique number
    // Max possible unique numbers is arrSize
    int* frequencies = (int*)malloc(arrSize * sizeof(int));
    if (frequencies == NULL) {
        // Handle allocation failure, though LeetCode environments usually guarantee success
        return 0; 
    }

    int freqCount = 0; // Number of distinct frequencies found
    int currentNum = arr[0];
    int count = 0;

    for (int i = 0; i < arrSize; ++i) {
        if (arr[i] == currentNum) {
            count++;
        } else {
            frequencies[freqCount++] = count; // Store frequency of previous number
            currentNum = arr[i];
            count = 1; // Start count for new number
        }
    }
    frequencies[freqCount++] = count; // Store the frequency of the last number group

    // 3. Sort the frequencies in ascending order
    // This allows us to remove elements that appear least frequently first
    qsort(frequencies, freqCount, sizeof(int), compareInt);

    // 4. Iterate through sorted frequencies and remove elements
    int uniqueCount = freqCount; // Start with the total number of unique integers
    for (int i = 0; i < freqCount; ++i) {
        if (k >= frequencies[i]) {
            // If we have enough removals (k) to remove all occurrences of this number
            k -= frequencies[i];
            uniqueCount--; // One unique integer is completely removed
        } else {
            // We don't have enough removals to eliminate this unique integer completely.
            // Since frequencies are sorted, we won't be able to eliminate any subsequent
            // unique integers either. So, we stop.
            break;
        }
    }

    // Free dynamically allocated memory
    free(frequencies);

    return uniqueCount;
}