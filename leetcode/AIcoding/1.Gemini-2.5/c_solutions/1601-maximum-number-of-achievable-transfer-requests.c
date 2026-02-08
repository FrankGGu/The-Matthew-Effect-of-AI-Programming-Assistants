#include <stdlib.h> // For calloc and free

void backtrack(int request_idx, int current_count, int n_buildings, int** requests, int requests_size, int* balance, int* max_ptr) {
    if (request_idx == requests_size) {
        for (int i = 0; i < n_buildings; i++) {
            if (balance[i] != 0) {
                return;
            }
        }
        if (current_count > *max_ptr) {
            *max_ptr = current_count;
        }
        return;
    }

    // Option 1: Don't include the current request
    backtrack(request_idx + 1, current_count, n_buildings, requests, requests_size, balance, max_ptr);

    // Option 2: Include the current request
    int from = requests[request_idx][0];
    int to = requests[request_idx][1];

    balance[from]--;
    balance[to]++;

    backtrack(request_idx + 1, current_count + 1, n_buildings, requests, requests_size, balance, max_ptr);

    // Backtrack: Undo the changes for the next branch
    balance[from]++;
    balance[to]--;
}

int maxRequests(int n, int** requests, int requestsSize, int* requestsColSize) {
    int max_achievable_requests = 0;
    int* balance = (int*)calloc(n, sizeof(int));

    backtrack(0, 0, n, requests, requestsSize, balance, &max_achievable_requests);

    free(balance);
    return max_achievable_requests;
}