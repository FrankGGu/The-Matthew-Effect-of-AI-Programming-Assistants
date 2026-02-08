int carPooling(int** trips, int tripsSize, int* tripsColSize, int capacity) {
    int locations[1001] = {0};

    for (int i = 0; i < tripsSize; i++) {
        int passengers = trips[i][0];
        int from = trips[i][1];
        int to = trips[i][2];

        locations[from] += passengers;
        locations[to] -= passengers;
    }

    int current = 0;
    for (int i = 0; i < 1001; i++) {
        current += locations[i];
        if (current > capacity) {
            return 0;
        }
    }

    return 1;
}