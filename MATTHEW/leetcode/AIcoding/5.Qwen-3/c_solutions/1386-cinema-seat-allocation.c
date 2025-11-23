#include <stdio.h>
#include <stdlib.h>

int* maxBookings(int* seatTypes, int seatTypesSize, int** bookings, int bookingsSize, int* bookingsColSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 2);
    int* seats = (int*)calloc(101, sizeof(int));
    int count = 0;
    int i;

    for (i = 0; i < bookingsSize; i++) {
        int start = bookings[i][0];
        int end = bookings[i][1];
        int type = bookings[i][2];
        int total = 0;

        if (type == 1) {
            for (int j = start; j <= end; j++) {
                if (seats[j] == 0) total++;
            }
            if (total > 0) {
                for (int j = start; j <= end; j++) {
                    if (seats[j] == 0) seats[j] = 1;
                }
                count++;
            }
        } else if (type == 2) {
            for (int j = start; j <= end; j += 2) {
                if (seats[j] == 0) total++;
            }
            if (total > 0) {
                for (int j = start; j <= end; j += 2) {
                    if (seats[j] == 0) seats[j] = 1;
                }
                count++;
            }
        } else if (type == 3) {
            for (int j = start; j <= end; j += 2) {
                if (seats[j] == 0) total++;
            }
            if (total > 0) {
                for (int j = start; j <= end; j += 2) {
                    if (seats[j] == 0) seats[j] = 1;
                }
                count++;
            }
        }
    }

    result[0] = count;
    *returnSize = 2;
    return result;
}