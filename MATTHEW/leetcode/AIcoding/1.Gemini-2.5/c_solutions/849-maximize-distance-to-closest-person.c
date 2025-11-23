#define MAX(a, b) ((a) > (b) ? (a) : (b))

int maxDistToClosest(int* seats, int seatsSize) {
    int max_dist = 0;
    int lastPerson = -1;

    for (int i = 0; i < seatsSize; i++) {
        if (seats[i] == 1) {
            if (lastPerson == -1) {
                max_dist = MAX(max_dist, i);
            } else {
                max_dist = MAX(max_dist, (i - lastPerson) / 2);
            }
            lastPerson = i;
        }
    }

    max_dist = MAX(max_dist, seatsSize - 1 - lastPerson);

    return max_dist;
}