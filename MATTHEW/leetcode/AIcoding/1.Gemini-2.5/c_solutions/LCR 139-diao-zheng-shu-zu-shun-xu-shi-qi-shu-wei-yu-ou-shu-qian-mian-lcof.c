#include <stdlib.h> // Required for qsort

int compareIntervals(const void* a, const void* b) {
    // 'a' and 'b' are pointers to elements of the array being sorted.
    // In this case, the array is `actions`, which is `int**`.
    // So, `a` and `b` are `const void*` pointing to `int*`.
    const int* intervalA = *(const int**)a;
    const int* intervalB = *(const int**)b;

    // Compare by end time (index 1)
    if (intervalA[1] != intervalB[1]) {
        return intervalA[1] - intervalB[1];
    }
    // If end times are equal, compare by start time (index 0)
    return intervalA[0] - intervalB[0];
}

int trainingPlan(int** actions, int actionsSize, int* actionsColSize) {
    if (actionsSize == 0) {
        return 0;
    }

    // Sort the actions based on their end times.
    // This is the core greedy step for the activity selection problem.
    qsort(actions, actionsSize, sizeof(int*), compareIntervals);

    int count = 0;
    // Initialize lastEndTime to a value that ensures the first activity can always be selected.
    // Assuming activity times are non-negative (common in LeetCode problems).
    int lastEndTime = -1; 

    // Iterate through the sorted activities
    for (int i = 0; i < actionsSize; ++i) {
        int startTime = actions[i][0];
        int endTime = actions[i][1];

        // If the current activity's start time is greater than or equal to
        // the end time of the last selected activity, select it.
        if (startTime >= lastEndTime) {
            count++;
            lastEndTime = endTime;
        }
    }

    return count;
}