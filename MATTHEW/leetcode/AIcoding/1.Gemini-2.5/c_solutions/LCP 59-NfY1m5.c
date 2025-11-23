#include <stdlib.h> // For qsort, malloc, free

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int min(int a, int b) {
    return a < b ? a : b;
}

int minTime(int* people, int peopleSize) {
    if (peopleSize == 0) {
        return 0;
    }
    if (peopleSize == 1) {
        return people[0];
    }

    qsort(people, peopleSize, sizeof(int), compare);

    int* dp = (int*)malloc(sizeof(int) * (peopleSize + 1));
    if (dp == NULL) {
        return -1; 
    }

    dp[0] = 0; 
    dp[1] = people[0]; 
    dp[2] = people[1]; 

    if (peopleSize >= 3) {
        dp[3] = people[0] + people[1] + people[2];
    }

    for (int i = 4; i <= peopleSize; ++i) {
        // Option A: Send fastest (people[0]) and slowest (people[i-1]) across, 
        //           fastest returns (people[0]), 
        //           send fastest (people[0]) and second slowest (people[i-2]) across,
        //           fastest returns (people[0]).
        // Total time for these two: people[i-1] + people[0] + people[i-2] + people[0]
        // Add time for remaining i-2 people: dp[i-2]
        int optionA = dp[i-2] + people[i-1] + 2 * people[0] + people[i-2];

        // Option B: Send fastest (people[0]) and second fastest (people[1]) across, 
        //           fastest returns (people[0]), 
        //           send slowest (people[i-1]) and second slowest (people[i-2]) across,
        //           second fastest returns (people[1]).
        // Total time for these two: people[1] + people[0] + people[i-1] + people[1]
        // Add time for remaining i-2 people: dp[i-2]
        int optionB = dp[i-2] + 2 * people[1] + people[0] + people[i-1];

        dp[i] = min(optionA, optionB);
    }

    int result = dp[peopleSize];
    free(dp); 
    return result;
}