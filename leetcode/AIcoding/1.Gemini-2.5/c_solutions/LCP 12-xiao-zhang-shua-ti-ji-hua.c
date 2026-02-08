#include <limits.h>

int check(int* time, int timeSize, int m, long long maxSum) {
    int days = 1;
    long long currentDaySum = 0;

    for (int i = 0; i < timeSize; i++) {
        // If adding the current task's time exceeds maxSum,
        // we must start a new day.
        if (currentDaySum + time[i] <= maxSum) {
            currentDaySum += time[i];
        } else {
            days++;
            currentDaySum = time[i]; // Start a new day with the current task
        }
    }
    // Return true if the number of days needed is within the allowed 'm'
    return days <= m;
}

int splitArray(int* time, int timeSize, int m) {
    long long low = 0;  // Lower bound for the binary search (minimum possible maximum sum)
    long long high = 0; // Upper bound for the binary search (maximum possible maximum sum)

    // Calculate the initial search range:
    // low: The largest single task time (a day must at least accommodate the largest task)
    // high: The sum of all task times (all tasks done in one day)
    for (int i = 0; i < timeSize; i++) {
        high += time[i];
        if (time[i] > low) {
            low = time[i];
        }
    }

    long long ans = high; // Initialize answer with the largest possible sum

    // Perform binary search on the possible range of 'maxSum'
    while (low <= high) {
        long long mid = low + (high - low) / 2; // Calculate the middle value

        if (check(time, timeSize, m, mid)) {
            // If it's possible to complete all tasks with 'mid' as the maximum daily sum,
            // it means 'mid' is a potential answer. We try to find an even smaller 'maxSum'.
            ans = mid;
            high = mid - 1;
        } else {
            // If it's not possible with 'mid' as the maximum daily sum,
            // we need a larger 'maxSum'.
            low = mid + 1;
        }
    }

    // The final 'ans' will be the minimum possible maximum daily sum.
    return (int)ans;
}