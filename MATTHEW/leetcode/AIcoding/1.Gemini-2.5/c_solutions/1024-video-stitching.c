#include <stdlib.h> // For qsort

int compareClips(const void *a, const void *b) {
    const int *clipA = *(const int **)a;
    const int *clipB = *(const int **)b;

    if (clipA[0] != clipB[0]) {
        return clipA[0] - clipB[0]; // Sort by start time ascending
    }
    return clipB[1] - clipA[1]; // If start times are equal, sort by end time descending
}

int videoStitching(int** clips, int clipsSize, int* clipsColSize, int T) {
    if (T == 0) {
        return 0;
    }

    qsort(clips, clipsSize, sizeof(int*), compareClips);

    int count = 0;
    int current_reach = 0; // The maximum time covered so far, starting from 0
    int i = 0;             // Pointer to the current clip being considered in the sorted array

    while (current_reach < T) {
        int max_end_for_this_step = current_reach;

        // Iterate through all clips that start at or before current_reach
        // and find the one that extends the furthest.
        // The 'i' pointer ensures we only consider clips not yet processed
        // for extending the current reach.
        while (i < clipsSize && clips[i][0] <= current_reach) {
            if (clips[i][1] > max_end_for_this_step) {
                max_end_for_this_step = clips[i][1];
            }
            i++;
        }

        // If no clip could extend beyond the current_reach, it's impossible to cover T.
        if (max_end_for_this_step == current_reach) {
            return -1;
        }

        current_reach = max_end_for_this_step;
        count++;
    }

    return count;
}