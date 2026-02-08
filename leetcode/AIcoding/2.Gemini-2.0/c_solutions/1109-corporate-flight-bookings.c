#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* corpFlightBookings(int** bookings, int bookingsSize, int* bookingsColSize, int n, int* returnSize){
    int *ans = (int*)malloc(sizeof(int) * n);
    for (int i = 0; i < n; i++) {
        ans[i] = 0;
    }

    for (int i = 0; i < bookingsSize; i++) {
        int first = bookings[i][0] - 1;
        int last = bookings[i][1] - 1;
        int seats = bookings[i][2];

        for (int j = first; j <= last; j++) {
            ans[j] += seats;
        }
    }

    *returnSize = n;
    return ans;
}