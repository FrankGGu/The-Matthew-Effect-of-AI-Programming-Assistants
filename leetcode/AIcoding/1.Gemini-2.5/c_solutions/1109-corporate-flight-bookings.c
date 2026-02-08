#include <stdlib.h> // Required for malloc

int* corpFlightBookings(int** bookings, int bookingsSize, int* bookingsColSize, int n, int* returnSize) {
    int* ans = (int*)calloc(n, sizeof(int));
    if (ans == NULL) {
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < bookingsSize; i++) {
        int first = bookings[i][0];
        int last = bookings[i][1];
        int seats = bookings[i][2];

        ans[first - 1] += seats;
        if (last < n) {
            ans[last] -= seats;
        }
    }

    for (int i = 1; i < n; i++) {
        ans[i] += ans[i - 1];
    }

    *returnSize = n;
    return ans;
}