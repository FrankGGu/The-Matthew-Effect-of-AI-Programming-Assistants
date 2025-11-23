int wateringPlants(int* plants, int plantsSize, int capacity) {
    int steps = 0, currentWater = capacity;

    for (int i = 0; i < plantsSize; i++) {
        if (currentWater < plants[i]) {
            steps += 2 * i; // Return to refill
            currentWater = capacity; // Refill
        }
        currentWater -= plants[i];
        steps++; // Water the plant
    }

    return steps;
}