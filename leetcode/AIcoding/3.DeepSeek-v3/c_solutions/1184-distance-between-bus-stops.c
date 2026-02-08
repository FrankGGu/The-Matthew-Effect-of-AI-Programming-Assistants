int distanceBetweenBusStops(int* distance, int distanceSize, int start, int destination) {
    if (start == destination) return 0;

    int total = 0;
    for (int i = 0; i < distanceSize; i++) {
        total += distance[i];
    }

    int clockwise = 0;
    int s = start;
    while (s != destination) {
        clockwise += distance[s];
        s = (s + 1) % distanceSize;
    }

    int counterclockwise = total - clockwise;
    return clockwise < counterclockwise ? clockwise : counterclockwise;
}