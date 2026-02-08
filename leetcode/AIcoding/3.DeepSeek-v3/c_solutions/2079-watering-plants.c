int wateringPlants(int* plants, int plantsSize, int capacity) {
    int steps = 0;
    int current_water = capacity;

    for (int i = 0; i < plantsSize; i++) {
        if (current_water < plants[i]) {
            steps += 2 * i;
            current_water = capacity;
        }
        steps++;
        current_water -= plants[i];
    }

    return steps;
}