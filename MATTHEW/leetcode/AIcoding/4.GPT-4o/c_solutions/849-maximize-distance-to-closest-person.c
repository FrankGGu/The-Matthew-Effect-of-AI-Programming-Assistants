int maxDistToClosest(int* seats, int seatsSize) {
    int maxDist = 0, lastPerson = -1, i;

    for (i = 0; i < seatsSize; i++) {
        if (seats[i] == 1) {
            if (lastPerson == -1) {
                maxDist = i; // Distance to the first person
            } else {
                maxDist = fmax(maxDist, (i - lastPerson) / 2); // Distance between two persons
            }
            lastPerson = i;
        }
    }

    // Check distance to the last person
    if (lastPerson != seatsSize - 1) {
        maxDist = fmax(maxDist, seatsSize - 1 - lastPerson);
    }

    return maxDist;
}