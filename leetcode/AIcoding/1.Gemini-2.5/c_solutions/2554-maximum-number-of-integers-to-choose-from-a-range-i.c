#include <stdlib.h> // Required for qsort and bsearch

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxCount(int* banned, int bannedSize, int n, int maxSum) {
    // Sort the banned array to enable efficient searching with bsearch.
    // This allows checking if a number is banned in O(log(bannedSize)) time.
    qsort(banned, bannedSize, sizeof(int), compare);

    long long currentSum = 0; // Stores the sum of chosen numbers. Use long long to prevent potential overflow.
    int count = 0;            // Stores the count of chosen numbers.

    // Iterate through numbers from 1 up to n.
    // We prioritize smaller numbers to maximize the count for a given maxSum.
    for (int i = 1; i <= n; ++i) {
        // Check if the current number 'i' is in the banned list.
        // bsearch returns a pointer to the found element, or NULL if not found.
        if (bsearch(&i, banned, bannedSize, sizeof(int), compare) == NULL) {
            // If 'i' is not banned, check if adding it would exceed maxSum.
            if (currentSum + i <= maxSum) {
                currentSum += i; // Add 'i' to the sum.
                count++;         // Increment the count.
            } else {
                // If adding 'i' would exceed maxSum, we cannot choose 'i'
                // or any subsequent larger numbers. So, we stop.
                break;
            }
        }
        // If 'i' is banned, we simply skip it and proceed to the next number.
    }

    return count; // Return the total count of chosen numbers.
}