#include <stdlib.h> // For qsort

int compareTasks(const void *a, const void *b) {
    // a and b are pointers to elements of the array being sorted.
    // Since 'tasks' is an array of 'int*', 'a' and 'b' are 'const void*'
    // pointing to an 'int*'. We need to dereference them to get the actual 'int*'.
    const int *taskA = *(const int **)a;
    const int *taskB = *(const int **)b;

    // Calculate the difference (minimum_required - actual_cost) for each task.
    // taskA[0] is actual_cost, taskA[1] is minimum_required.
    int diffA = taskA[1] - taskA[0];
    int diffB = taskB[1] - taskB[0];

    // For descending order, if diffB is greater than diffA, taskB should come before taskA.
    // qsort expects a positive return value if the first argument should come after the second.
    // So, if diffB > diffA, we want taskB to come before taskA, which means taskA comes after taskB.
    // Thus, return diffB - diffA.
    return diffB - diffA;
}

long long minEnergy(int** tasks, int tasksSize, int* tasksColSize) {
    // If there are no tasks, no energy is needed.
    if (tasksSize == 0) {
        return 0;
    }

    // Sort the tasks using the custom comparison function.
    // The tasks are sorted in descending order of (minimum_required - actual_cost).
    qsort(tasks, tasksSize, sizeof(int*), compareTasks);

    // min_initial_energy stores the minimum initial energy required.
    // current_energy tracks the energy we have *before* starting the current task.
    // Both need to be long long to prevent overflow, as total energy can be large.
    long long min_initial_energy = 0;
    long long current_energy = 0;

    // Iterate through the sorted tasks.
    for (int i = 0; i < tasksSize; i++) {
        int actual_cost = tasks[i][0];
        int minimum_required = tasks[i][1];

        // If our current energy is less than the minimum required for this task,
        // we must have started with more initial energy to meet this requirement.
        if (current_energy < minimum_required) {
            // Calculate how much more energy was needed at the start of this task.
            long long needed = minimum_required - current_energy;
            // Add this deficit to our total minimum initial energy.
            min_initial_energy += needed;
            // Conceptually, we "top up" our current energy to meet the requirement
            // for this task, as if we had started with 'needed' more energy.
            current_energy += needed;
        }

        // After starting the task, we consume its actual_cost.
        current_energy -= actual_cost;
    }

    return min_initial_energy;
}