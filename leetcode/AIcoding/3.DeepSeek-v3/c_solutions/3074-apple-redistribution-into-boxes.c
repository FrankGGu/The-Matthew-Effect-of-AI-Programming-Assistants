int minimumBoxes(int* apple, int appleSize, int* capacity, int capacitySize) {
    int totalApples = 0;
    for (int i = 0; i < appleSize; i++) {
        totalApples += apple[i];
    }

    for (int i = 0; i < capacitySize - 1; i++) {
        for (int j = 0; j < capacitySize - i - 1; j++) {
            if (capacity[j] < capacity[j + 1]) {
                int temp = capacity[j];
                capacity[j] = capacity[j + 1];
                capacity[j + 1] = temp;
            }
        }
    }

    int boxCount = 0;
    int currentCapacity = 0;
    for (int i = 0; i < capacitySize; i++) {
        if (currentCapacity >= totalApples) {
            break;
        }
        currentCapacity += capacity[i];
        boxCount++;
    }

    return boxCount;
}