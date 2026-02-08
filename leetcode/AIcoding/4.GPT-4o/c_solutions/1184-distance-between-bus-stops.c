int distanceBetweenBusStops(int* distance, int distanceSize, int start, int destination) {
    if (start > destination) {
        int temp = start;
        start = destination;
        destination = temp;
    }

    int directDistance = 0;
    for (int i = start; i < destination; i++) {
        directDistance += distance[i];
    }

    int totalDistance = 0;
    for (int i = 0; i < distanceSize; i++) {
        totalDistance += distance[i];
    }

    return (directDistance < (totalDistance - directDistance)) ? directDistance : (totalDistance - directDistance);
}