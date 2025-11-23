/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* corpFlightBookings(int** bookings, int bookingsSize, int* bookingsColSize, int n, int* returnSize) {
    int* result = (int*)calloc(n, sizeof(int));
    *returnSize = n;

    for (int i = 0; i < bookingsSize; i++) {
        int first = bookings[i][0] - 1;
        int last = bookings[i][1] - 1;
        int seats = bookings[i][2];

        result[first] += seats;
        if (last + 1 < n) {
            result[last + 1] -= seats;
        }
    }

    for (int i = 1; i < n; i++) {
        result[i] += result[i - 1];
    }

    return result;
}