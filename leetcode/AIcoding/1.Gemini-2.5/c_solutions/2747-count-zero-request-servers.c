#include <stdlib.h>

typedef struct {
    int query_time;
    int window_size;
    int original_index;
} Query;

int compareQueries(const void *a, const void *b) {
    return ((Query *)a)->query_time - ((Query *)b)->query_time;
}

int* countServers(int n, int** logs, int logsSize, int* logsColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    // Prepare queries for sorting, storing original indices
    Query* sortedQueries = (Query*)malloc(queriesSize * sizeof(Query));
    for (int i = 0; i < queriesSize; ++i) {
        sortedQueries[i].query_time = queries[i][0];
        sortedQueries[i].window_size = queries[i][1];
        sortedQueries[i].original_index = i;
    }

    // Sort queries by query_time
    qsort(sortedQueries, queriesSize, sizeof(Query), compareQueries);

    // Prepare result array
    int* ans = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    // Data structures for sliding window
    // server_counts[i] stores the number of requests for server i in the current window
    // Use calloc to initialize all counts to 0
    int* server_counts = (int*)calloc(n + 1, sizeof(int)); // n+1 because server_id is 1-indexed
    int active_server_count = 0; // Number of unique servers with at least one request

    int log_left = 0;  // Left pointer for logs array
    int log_right = 0; // Right pointer for logs array

    // Iterate through sorted queries
    for (int i = 0; i < queriesSize; ++i) {
        int q_time = sortedQueries[i].query_time;
        int w_size = sortedQueries[i].window_size;
        int start_time = q_time - w_size; // Inclusive start of the window: [start_time, q_time]

        // Expand window (add logs where log_time <= q_time)
        while (log_right < logsSize && logs[log_right][1] <= q_time) {
            int server_id = logs[log_right][0];
            server_counts[server_id]++;
            if (server_counts[server_id] == 1) { // Server just became active in the window
                active_server_count++;
            }
            log_right++;
        }

        // Shrink window (remove logs where log_time < start_time)
        while (log_left < logsSize && logs[log_left][1] < start_time) {
            int server_id = logs[log_left][0];
            server_counts[server_id]--;
            if (server_counts[server_id] == 0) { // Server just became inactive in the window
                active_server_count--;
            }
            log_left++;
        }

        // Calculate result for the current query: total servers - active servers
        ans[sortedQueries[i].original_index] = n - active_server_count;
    }

    // Free allocated memory
    free(sortedQueries);
    free(server_counts);

    return ans;
}