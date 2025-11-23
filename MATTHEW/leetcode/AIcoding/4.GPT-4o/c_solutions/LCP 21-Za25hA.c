bool chaseGame(int* position, int positionSize, int* speed, int speedSize) {
    if (positionSize != speedSize || positionSize < 2) return false;

    double timeToCatch = (double)(position[1] - position[0]) / (speed[0] - speed[1]);

    if (timeToCatch < 0) return false;

    for (int i = 2; i < positionSize; i++) {
        if (position[i] > position[0] + speed[0] * timeToCatch) {
            return false;
        }
    }

    return true;
}