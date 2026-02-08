#include <stdlib.h> // For qsort
#include <stdio.h>  // For NULL, though not strictly needed for the solution itself

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minimumRounds(int* tasks, int tasksSize) {
    if (tasksSize == 0) {
        return 0;
    }

    // Sort the tasks array to group identical difficulties together
    qsort(tasks, tasksSize, sizeof(int), compare);

    long long totalRounds = 0;
    int i = 0;
    while (i < tasksSize) {
        int currentTaskDifficulty = tasks[i];
        int count = 0;
        // Count occurrences of the current task difficulty
        while (i < tasksSize && tasks[i] == currentTaskDifficulty) {
            count++;
            i++;
        }

        // If any task difficulty has a count of 1, it's impossible to complete
        if (count == 1) {
            return -1;
        }

        // Calculate rounds for this difficulty
        // (count + 2) / 3 effectively handles all cases:
        // If count % 3 == 0, rounds = count / 3
        // If count % 3 == 1, rounds = (count - 4) / 3 + 2 = (count + 2) / 3
        // If count % 3 == 2, rounds = (count - 2) / 3 + 1 = (count + 2) / 3
        totalRounds += (count + 2) / 3;
    }

    return (int)totalRounds;
}