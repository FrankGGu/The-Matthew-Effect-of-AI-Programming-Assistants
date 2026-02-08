#include <limits.h>
#include <stdlib.h>

static inline int max(int a, int b) {
    return a > b ? a : b;
}

int minSessions(int* tasks, int tasksSize, int sessionTime) {
    int n = tasksSize;
    int num_masks = 1 << n;

    int* dp = (int*)malloc(num_masks * sizeof(int));
    int* rem = (int*)malloc(num_masks * sizeof(int));

    for (int i = 0; i < num_masks; ++i) {
        dp[i] = INT_MAX;
        rem[i] = 0;
    }

    dp[0] = 0;
    rem[0] = 0;

    for (int mask = 0; mask < num_masks; ++mask) {
        if (dp[mask] == INT_MAX) {
            continue;
        }

        for (int i = 0; i < n; ++i) {
            if (!((mask >> i) & 1)) {
                int next_mask = mask | (1 << i);

                int current_sessions = dp[mask];
                int current_remaining_time = rem[mask];

                int new_sessions;
                int new_remaining_time;

                if (current_remaining_time >= tasks[i]) {
                    new_sessions = current_sessions;
                    new_remaining_time = current_remaining_time - tasks[i];
                } else {
                    new_sessions = current_sessions + 1;
                    new_remaining_time = sessionTime - tasks[i];
                }

                if (new_sessions < dp[next_mask]) {
                    dp[next_mask] = new_sessions;
                    rem[next_mask] = new_remaining_time;
                } else if (new_sessions == dp[next_mask]) {
                    rem[next_mask] = max(rem[next_mask], new_remaining_time);
                }
            }
        }
    }

    int result = dp[num_masks - 1];

    free(dp);
    free(rem);

    return result;
}