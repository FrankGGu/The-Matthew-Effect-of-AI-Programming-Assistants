int maxDistToClosest(int* seats, int seatsSize) {
    int maxDist = 0;
    int lastPerson = -1;

    for (int i = 0; i < seatsSize; i++) {
        if (seats[i] == 1) {
            if (lastPerson == -1) {
                maxDist = i;
            } else {
                int dist = (i - lastPerson) / 2;
                if (dist > maxDist) {
                    maxDist = dist;
                }
            }
            lastPerson = i;
        }
    }

    if (seats[seatsSize - 1] == 0) {
        int dist = seatsSize - 1 - lastPerson;
        if (dist > maxDist) {
            maxDist = dist;
        }
    }

    return maxDist;
}