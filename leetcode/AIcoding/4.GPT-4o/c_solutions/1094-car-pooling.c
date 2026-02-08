#define MAX_SIZE 1001

int carPooling(int** trips, int tripsSize, int* tripsColSize, int capacity) {
    int timeline[MAX_SIZE] = {0};

    for (int i = 0; i < tripsSize; i++) {
        int numPassengers = trips[i][0];
        int start = trips[i][1];
        int end = trips[i][2];
        timeline[start] += numPassengers;
        timeline[end] -= numPassengers;
    }

    int currentPassengers = 0;
    for (int i = 0; i < MAX_SIZE; i++) {
        currentPassengers += timeline[i];
        if (currentPassengers > capacity) {
            return 0;
        }
    }

    return 1;
}