#include <stdlib.h> // Required for malloc and free

int firstDayBeenInAllRooms(int* nextRoom, int nextRoomSize) {
    int n = nextRoomSize;
    long long MOD = 1e9 + 7;

    // dp[i] will store the day we first arrive at room i.
    // This implies that by day dp[i], all rooms from 0 to i have been visited at least once.
    // Specifically, dp[i] is the day when we arrive at room i, having completed
    // the full cycle for room i-1 (i.e., visited i-1 an even number of times and moved to i).
    long long* dp = (long long*)malloc(n * sizeof(long long));
    // It's good practice to check for malloc failure, though LeetCode environments
    // usually guarantee success for typical problem constraints.
    if (dp == NULL) {
        return -1; // Indicate an error
    }

    dp[0] = 0; // We start at room 0 on day 0.

    // Iterate from room 0 up to room n-2 to calculate dp[i+1]
    for (int i = 0; i < n - 1; i++) {
        // To calculate dp[i+1] (the day we first arrive at room i+1):
        // 1. We are at room i on day dp[i].
        // 2. We visit room i. Since this is the first time in this "cycle" towards i+1,
        //    room i has been visited an odd number of times. We move to nextRoom[i].
        //    This takes 1 day. So, day is dp[i] + 1.
        // 3. Now we are at nextRoom[i]. We need to return to room i to make its visit count even,
        //    so we can then move to i+1.
        //    The time taken to traverse from nextRoom[i] back to room i (i.e., to arrive at room i
        //    after having completed the cycle for nextRoom[i] and all rooms up to i-1) is
        //    dp[i] - dp[nextRoom[i]].
        //    So, we arrive back at room i on day: (dp[i] + 1) + (dp[i] - dp[nextRoom[i]]).
        // 4. We visit room i again. Now room i has been visited an even number of times.
        //    We move to room (i + 1) % n. This takes 1 day.
        //    The day we arrive at room i+1 is: (dp[i] + 1) + (dp[i] - dp[nextRoom[i]]) + 1.
        //    This simplifies to 2 * dp[i] - dp[nextRoom[i]] + 2.

        long long val = (2LL * dp[i] - dp[nextRoom[i]] + 2);

        // Apply modulo arithmetic, ensuring the result is non-negative
        dp[i+1] = (val % MOD + MOD) % MOD;
    }

    // The problem asks for the first day where all rooms (0 to n-1) have been visited.
    // By the time we first arrive at room n-1 (which is dp[n-1]), all rooms from 0 to n-1
    // must have been visited at least once.
    long long result = dp[n-1];

    // Free the allocated memory
    free(dp);

    return (int)result;
}