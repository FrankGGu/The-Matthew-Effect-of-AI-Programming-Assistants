int* corpFlightBookings(int** bookings, int bookingsSize, int* bookingsColSize, int* returnSize) {
    int n = bookingsSize;
    int* result = (int*)calloc(bookingsColSize[0], sizeof(int));
    int* delta = (int*)calloc(bookingsColSize[0] + 1, sizeof(int));

    for (int i = 0; i < n; i++) {
        int start = bookings[i][0] - 1;
        int end = bookings[i][1];
        int seats = bookings[i][2];
        delta[start] += seats;
        delta[end] -= seats;
    }

    for (int i = 1; i <= bookingsColSize[0]; i++) {
        delta[i] += delta[i - 1];
        result[i - 1] = delta[i];
    }

    *returnSize = bookingsColSize[0];
    free(delta);
    return result;
}