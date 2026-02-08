#include <stdio.h>
#include <stdlib.h>

int* corpFlightBookings(int** bookings, int bookingsSize, int* bookingsColSize, int n, int* returnSize) {
    int* res = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < bookingsSize; i++) {
        int start = bookings[i][0] - 1;
        int end = bookings[i][1] - 1;
        int val = bookings[i][2];
        res[start] += val;
        if (end + 1 < n) {
            res[end + 1] -= val;
        }
    }
    for (int i = 1; i < n; i++) {
        res[i] += res[i - 1];
    }
    *returnSize = n;
    return res;
}