#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumRequests(int n, int** requests, int requestsSize, int* requestsColSize) {
    int max_requests = 0;
    int num_requests = requestsSize;

    for (int i = 0; i < (1 << num_requests); i++) {
        int count = 0;
        int balance[n];
        for (int j = 0; j < n; j++) {
            balance[j] = 0;
        }

        for (int j = 0; j < num_requests; j++) {
            if ((i >> j) & 1) {
                balance[requests[j][0]]--;
                balance[requests[j][1]]++;
                count++;
            }
        }

        bool valid = true;
        for (int j = 0; j < n; j++) {
            if (balance[j] != 0) {
                valid = false;
                break;
            }
        }

        if (valid) {
            if (count > max_requests) {
                max_requests = count;
            }
        }
    }

    return max_requests;
}