#include <stdlib.h> // Required for qsort

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

long long minimumTime(int* locks, int locksSize, int k) {
    // Sort the locks array in descending order based on their initial breaking times.
    // This greedy strategy minimizes the total time because locks with higher initial costs
    // are broken when the penalty (j * k) is smallest (i.e., when j is small).
    qsort(locks, locksSize, sizeof(int), compare);

    long long totalTime = 0;
    // Iterate through the sorted locks.
    for (int i = 0; i < locksSize; i++) {
        // 'i' represents the number of locks already broken before the current lock.
        // For the 0-th lock in the sorted array, i = 0 (0 locks broken before).
        // For the 1-st lock, i = 1 (1 lock broken before), and so on.
        // The actual time to break this lock is locks[i] + i * k.
        totalTime += (long long)locks[i] + (long long)i * k;
    }

    return totalTime;
}